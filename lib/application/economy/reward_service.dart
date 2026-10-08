import 'dart:async';
import '../../core/constants/game_constants.dart';
import '../../domain/models/game_mode.dart';
import '../../domain/repositories/settings_repository.dart';
import '../analytics/analytics_event.dart';
import '../analytics/analytics_service.dart';

class RewardService {
  final SettingsRepository settingsRepository;
  final AnalyticsService analyticsService;

  final _coinStreamController = StreamController<int>.broadcast();
  int _cachedCoins = GameConstants.startingCoins;

  RewardService({
    required this.settingsRepository,
    required this.analyticsService,
  });

  Stream<int> get coinStream => _coinStreamController.stream;
  int get currentCoins => _cachedCoins;

  Future<void> initialize() async {
    _cachedCoins = await settingsRepository.getCoins();
    _coinStreamController.add(_cachedCoins);
  }

  Future<int> addCoins(int amount, {required String reason}) async {
    if (amount <= 0) return _cachedCoins;

    _cachedCoins += amount;
    await settingsRepository.setCoins(_cachedCoins);
    _coinStreamController.add(_cachedCoins);

    return _cachedCoins;
  }

  Future<bool> spendCoins(int amount, {required String reason}) async {
    if (amount <= 0) return true;
    if (_cachedCoins < amount) return false;

    _cachedCoins -= amount;
    await settingsRepository.setCoins(_cachedCoins);
    _coinStreamController.add(_cachedCoins);

    return true;
  }

  Future<bool> canAffordHint() async {
    return _cachedCoins >= GameConstants.hintCostCoins;
  }

  Future<bool> spendForHint() async {
    final success = await spendCoins(
      GameConstants.hintCostCoins,
      reason: 'hint_purchased',
    );
    if (success) {
      await analyticsService.logEvent(AnalyticsEventType.hintUsed, {
        'cost': GameConstants.hintCostCoins,
        'remaining_coins': _cachedCoins,
      });
    }
    return success;
  }

  Future<int> awardMatchBonus(int matchesCount) async {
    // Every 5 matches, award 5 bonus coins
    if (matchesCount > 0 && matchesCount % 5 == 0) {
      const reward = 5;
      await addCoins(reward, reason: 'matches_milestone');
      return reward;
    }
    return 0;
  }

  Future<int> awardRowClearBonus() async {
    const reward = 10;
    await addCoins(reward, reason: 'row_clear_bonus');
    return reward;
  }

  Future<int> awardGameVictory(GameMode mode, int score) async {
    final reward = mode == GameMode.daily
        ? GameConstants.dailyChallengeRewardCoins
        : GameConstants.gameWinRewardCoins;

    await addCoins(reward, reason: 'victory_${mode.storageKey}');
    return reward;
  }

  Future<int> awardRewardedAd() async {
    const reward = GameConstants.rewardedAdCoins;
    await addCoins(reward, reason: 'rewarded_ad_watched');
    await analyticsService.logEvent(AnalyticsEventType.rewardedAdCompleted, {
      'coins_awarded': reward,
    });
    return reward;
  }

  void dispose() {
    _coinStreamController.close();
  }
}
