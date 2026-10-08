import 'board_model.dart';
import 'game_mode.dart';
import 'match_pair.dart';
import 'move_history.dart';

class GameState {
  final String id;
  final GameMode mode;
  final BoardModel board;
  final int score;
  final int combo;
  final int maxCombo;
  final int matchesCount;
  final int addsCount;
  final int elapsedSeconds;
  final int? selectedIndex;
  final MatchPair? hintPair;
  final int? invalidPairTargetIndex;
  final bool isCompleted;
  final bool isWon;
  final int? targetScore;
  final int? targetTimeSeconds;
  final int? seed;
  final List<MoveHistory> undoHistory;

  const GameState({
    required this.id,
    required this.mode,
    required this.board,
    this.score = 0,
    this.combo = 1,
    this.maxCombo = 1,
    this.matchesCount = 0,
    this.addsCount = 0,
    this.elapsedSeconds = 0,
    this.selectedIndex,
    this.hintPair,
    this.invalidPairTargetIndex,
    this.isCompleted = false,
    this.isWon = false,
    this.targetScore,
    this.targetTimeSeconds,
    this.seed,
    this.undoHistory = const [],
  });

  bool get canUndo => undoHistory.isNotEmpty && !isCompleted;

  int get remainingSeconds {
    if (targetTimeSeconds == null) return 0;
    final remaining = targetTimeSeconds! - elapsedSeconds;
    return remaining < 0 ? 0 : remaining;
  }

  bool get isTimeExpired =>
      targetTimeSeconds != null && elapsedSeconds >= targetTimeSeconds!;

  GameState copyWith({
    String? id,
    GameMode? mode,
    BoardModel? board,
    int? score,
    int? combo,
    int? maxCombo,
    int? matchesCount,
    int? addsCount,
    int? elapsedSeconds,
    int? selectedIndex,
    bool clearSelected = false,
    MatchPair? hintPair,
    bool clearHint = false,
    int? invalidPairTargetIndex,
    bool clearInvalid = false,
    bool? isCompleted,
    bool? isWon,
    int? targetScore,
    int? targetTimeSeconds,
    int? seed,
    List<MoveHistory>? undoHistory,
  }) {
    return GameState(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      board: board ?? this.board,
      score: score ?? this.score,
      combo: combo ?? this.combo,
      maxCombo: maxCombo ?? this.maxCombo,
      matchesCount: matchesCount ?? this.matchesCount,
      addsCount: addsCount ?? this.addsCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      selectedIndex: clearSelected ? null : (selectedIndex ?? this.selectedIndex),
      hintPair: clearHint ? null : (hintPair ?? this.hintPair),
      invalidPairTargetIndex: clearInvalid
          ? null
          : (invalidPairTargetIndex ?? this.invalidPairTargetIndex),
      isCompleted: isCompleted ?? this.isCompleted,
      isWon: isWon ?? this.isWon,
      targetScore: targetScore ?? this.targetScore,
      targetTimeSeconds: targetTimeSeconds ?? this.targetTimeSeconds,
      seed: seed ?? this.seed,
      undoHistory: undoHistory ?? this.undoHistory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mode': mode.storageKey,
      'board': board.toJson(),
      'score': score,
      'combo': combo,
      'maxCombo': maxCombo,
      'matchesCount': matchesCount,
      'addsCount': addsCount,
      'elapsedSeconds': elapsedSeconds,
      'selectedIndex': selectedIndex,
      'isCompleted': isCompleted,
      'isWon': isWon,
      'targetScore': targetScore,
      'targetTimeSeconds': targetTimeSeconds,
      'seed': seed,
      'undoHistory': undoHistory.map((u) => u.toJson()).toList(),
    };
  }

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      id: json['id'] as String,
      mode: GameModeExtension.fromStorageKey(json['mode'] as String),
      board: BoardModel.fromJson(json['board'] as Map<String, dynamic>),
      score: json['score'] as int? ?? 0,
      combo: json['combo'] as int? ?? 1,
      maxCombo: json['maxCombo'] as int? ?? 1,
      matchesCount: json['matchesCount'] as int? ?? 0,
      addsCount: json['addsCount'] as int? ?? 0,
      elapsedSeconds: json['elapsedSeconds'] as int? ?? 0,
      selectedIndex: json['selectedIndex'] as int?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isWon: json['isWon'] as bool? ?? false,
      targetScore: json['targetScore'] as int?,
      targetTimeSeconds: json['targetTimeSeconds'] as int?,
      seed: json['seed'] as int?,
      undoHistory: (json['undoHistory'] as List<dynamic>?)
              ?.map((u) => MoveHistory.fromJson(u as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}
