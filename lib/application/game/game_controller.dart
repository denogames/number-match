import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_core_sdk/studio_core_sdk.dart';
import '../../core/audio/audio_feedback_service.dart';
import '../../core/constants/game_constants.dart';
import '../../core/haptics/haptic_feedback_service.dart';
import '../../domain/engine/number_match_engine.dart';
import '../../domain/models/daily_challenge_meta.dart';
import '../../domain/models/game_mode.dart';
import '../../domain/models/game_state.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/repositories/stats_repository.dart';
import '../analytics/analytics_event.dart';
import '../analytics/analytics_service.dart';
import '../economy/reward_service.dart';
import '../providers.dart';

class GameController extends Notifier<GameState?> {
  Timer? _gameTimer;

  @override
  GameState? build() {
    ref.onDispose(() {
      _gameTimer?.cancel();
    });
    return null;
  }

  NumberMatchEngine get engine => ref.read(gameEngineProvider);
  GameRepository get gameRepository => ref.read(gameRepositoryProvider);
  StatsRepository get statsRepository => ref.read(statsRepositoryProvider);
  RewardService get rewardService => ref.read(rewardServiceProvider);
  AnalyticsService get analyticsService => ref.read(analyticsServiceProvider);
  HapticFeedbackService get haptics => ref.read(hapticServiceProvider);
  AudioFeedbackService get audio => ref.read(audioServiceProvider);

  // Load existing or initialize fresh game
  Future<void> loadOrCreateGame(GameMode mode, {DateTime? date}) async {
    _gameTimer?.cancel();

    // Check if there is an active session
    final savedGame = await gameRepository.loadActiveGame(mode);
    if (savedGame != null && !savedGame.isCompleted) {
      state = savedGame;
      _startTimerIfNeeded();
      return;
    }

    // Otherwise initialize new game
    switch (mode) {
      case GameMode.classic:
        state = engine.initClassicGame();
        break;
      case GameMode.daily:
        final targetDate = date ?? DateTime.now();
        state = engine.initDailyGame(targetDate);
        break;
      case GameMode.timed:
        final duration = StudioSdk.isInitialized
            ? StudioSdk.instance.liveOps.getBalanceValue<int>(
                'timedRushDurationSeconds',
                defaultValue: GameConstants.timedRushDurationSeconds,
              )
            : GameConstants.timedRushDurationSeconds;
        state = engine.initTimedGame(durationSeconds: duration);
        break;
    }

    await gameRepository.saveActiveGame(state!);
    await analyticsService.logEvent(AnalyticsEventType.gameStarted, {
      'mode': mode.storageKey,
      'seed': state!.seed,
    });

    _startTimerIfNeeded();
  }

  void _startTimerIfNeeded() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state == null || state!.isCompleted) {
        _gameTimer?.cancel();
        return;
      }
      final updated = engine.tickTimer(state!, seconds: 1);
      state = updated;

      if (updated.isCompleted) {
        _gameTimer?.cancel();
        _handleGameCompletion(updated, isWon: false);
      }
    });
  }

  // Handle cell tap
  Future<SelectResult?> tapCell(int index) async {
    final current = state;
    if (current == null || current.isCompleted) return null;

    final result = engine.selectCell(current, index);
    state = result.state;

    switch (result.outcome) {
      case SelectionOutcome.cellSelected:
        await haptics.selection();
        await audio.playSelect();
        break;

      case SelectionOutcome.cellDeselected:
        await haptics.selection();
        break;

      case SelectionOutcome.matchInvalid:
        await haptics.invalid();
        await audio.playInvalid();
        await analyticsService.logEvent(AnalyticsEventType.invalidPair, {
          'mode': current.mode.storageKey,
        });
        break;

      case SelectionOutcome.matchSuccess:
        if (result.combo > 1) {
          await haptics.comboBonus();
          await audio.playCombo();
        } else {
          await haptics.matchSuccess();
          await audio.playMatch();
        }

        await analyticsService.logEvent(AnalyticsEventType.pairMatched, {
          'points': result.pointsGained,
          'combo': result.combo,
          'reason': result.matchedPair?.reason.name,
        });

        // Economy rewards
        await rewardService.awardMatchBonus(result.state.matchesCount);
        if (result.rowsClearedCount > 0) {
          await rewardService.awardRowClearBonus();
        }

        if (result.isBoardCleared) {
          await _handleGameCompletion(result.state, isWon: true);
        } else {
          await gameRepository.saveActiveGame(result.state);
        }

        if (StudioSdk.isInitialized) {
          final remaining = result.state.board.remainingActiveCount;
          final total = result.state.board.cells.length;
          final ratio = total > 0 ? (total - remaining) / total : 0.5;
          StudioSdk.instance.pinchPoint.updateGameplayTelemetry(levelCompletionRatio: ratio);
        }
        break;

      case SelectionOutcome.ignored:
        break;
    }

    return result;
  }

  // Add numbers to board
  Future<void> addNumbers() async {
    final current = state;
    if (current == null || current.isCompleted) return;

    final updated = engine.addNumbers(current);
    state = updated;

    await haptics.selection();
    await audio.playSelect();
    await analyticsService.logEvent(AnalyticsEventType.numbersAdded, {
      'mode': current.mode.storageKey,
      'adds_count': updated.addsCount,
      'active_cells': updated.board.remainingActiveCount,
    });

    await gameRepository.saveActiveGame(updated);
  }

  // Undo last move
  Future<void> undo() async {
    final current = state;
    if (current == null || !current.canUndo) return;

    final updated = engine.undo(current);
    state = updated;

    await haptics.selection();
    await audio.playSelect();
    await analyticsService.logEvent(AnalyticsEventType.undoUsed, {
      'mode': current.mode.storageKey,
    });

    await gameRepository.saveActiveGame(updated);
  }

  // Request hint (spends coins via RewardService)
  Future<bool> requestHint() async {
    final current = state;
    if (current == null || current.isCompleted) return false;

    // Check economy affordability
    final canAfford = await rewardService.canAffordHint();
    if (!canAfford) {
      if (StudioSdk.isInitialized) {
        final remaining = current.board.remainingActiveCount;
        final total = current.board.cells.length;
        final ratio = total > 0 ? (total - remaining) / total : 0.5;
        unawaited(StudioSdk.instance.pinchPoint.evaluateGameContext(
          depletedCurrencyId: StudioCurrencyIds.gold,
          levelCompletionRatio: ratio,
        ));
      }
      return false;
    }

    final spent = await rewardService.spendForHint();
    if (!spent) return false;

    final updated = engine.requestHint(current);
    state = updated;

    await haptics.selection();
    await audio.playSelect();

    return true;
  }

  // Load a remote dynamic puzzle level pack from CMS/Cloudflare R2 via LiveOps
  Future<bool> loadRemotePuzzleLevel(String packId, {int levelNumber = 1}) async {
    if (!StudioSdk.isInitialized) return false;
    _gameTimer?.cancel();
    final pack = await StudioSdk.instance.liveOps.getPuzzleLevelPack(packId);
    final levels = pack['levels'] as List<dynamic>?;
    if (levels != null && levels.isNotEmpty) {
      final level = levels.firstWhere(
        (lvl) => (lvl as Map)['levelNumber'] == levelNumber,
        orElse: () => levels.first,
      ) as Map<dynamic, dynamic>;

      final dynamic rawValues = level['values'] ?? level['solutionRows'];
      List<int>? values;
      if (rawValues is List) {
        if (rawValues.isNotEmpty && rawValues.first is List) {
          values = rawValues
              .expand((row) => (row as List).map((v) => (v as num).toInt()))
              .toList();
        } else {
          values = rawValues.map((v) => (v as num).toInt()).toList();
        }
      }

      if (values != null && values.isNotEmpty) {
        state = engine.initCustomLevelGame(
          values,
          id: '${packId}_lvl_$levelNumber',
        );
        await gameRepository.saveActiveGame(state!);
        _startTimerIfNeeded();
        return true;
      }
    }
    return false;
  }

  Future<void> _handleGameCompletion(GameState completedState, {required bool isWon}) async {
    _gameTimer?.cancel();

    if (isWon) {
      await audio.playVictory();
      await haptics.comboBonus();
      await rewardService.awardGameVictory(completedState.mode, completedState.score);
    }

    // Record lifetime stats
    await statsRepository.recordGameResult(
      mode: completedState.mode,
      score: completedState.score,
      combo: completedState.maxCombo,
      matches: completedState.matchesCount,
      adds: completedState.addsCount,
      timeSeconds: completedState.elapsedSeconds,
      isWon: isWon,
    );

    // If Daily Challenge, record completion
    if (completedState.mode == GameMode.daily) {
      final now = DateTime.now();
      final dateKey =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final meta = DailyChallengeMeta(
        dateKey: dateKey,
        isCompleted: isWon,
        score: completedState.score,
        moves: completedState.matchesCount,
        elapsedSeconds: completedState.elapsedSeconds,
        completedAt: now,
      );
      await gameRepository.saveDailyChallenge(meta);
    }

    await analyticsService.logEvent(AnalyticsEventType.gameCompleted, {
      'mode': completedState.mode.storageKey,
      'score': completedState.score,
      'won': isWon,
      'elapsed_seconds': completedState.elapsedSeconds,
    });

    // Remove active game session from local DB
    await gameRepository.deleteActiveGame(completedState.mode);
  }

  Future<void> restartGame() async {
    final current = state;
    if (current == null) return;
    await gameRepository.deleteActiveGame(current.mode);
    await loadOrCreateGame(current.mode);
  }

  Future<void> abandonGame() async {
    final current = state;
    if (current == null) return;

    _gameTimer?.cancel();
    await analyticsService.logEvent(AnalyticsEventType.gameAbandoned, {
      'mode': current.mode.storageKey,
      'score': current.score,
      'elapsed_seconds': current.elapsedSeconds,
    });

    await gameRepository.deleteActiveGame(current.mode);
    state = null;
  }
}
