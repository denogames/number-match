class GameStatistics {
  final int gamesPlayed;
  final int gamesWon;
  final int bestScore;
  final int totalScore;
  final int bestCombo;
  final int totalPairsMatched;
  final int totalNumbersAdded;
  final int totalTimeSeconds;
  final int currentStreak;
  final int bestStreak;

  const GameStatistics({
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.bestScore = 0,
    this.totalScore = 0,
    this.bestCombo = 0,
    this.totalPairsMatched = 0,
    this.totalNumbersAdded = 0,
    this.totalTimeSeconds = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
  });

  double get winRate =>
      gamesPlayed == 0 ? 0.0 : (gamesWon / gamesPlayed) * 100.0;

  double get averageScore =>
      gamesPlayed == 0 ? 0.0 : totalScore / gamesPlayed;

  GameStatistics copyWith({
    int? gamesPlayed,
    int? gamesWon,
    int? bestScore,
    int? totalScore,
    int? bestCombo,
    int? totalPairsMatched,
    int? totalNumbersAdded,
    int? totalTimeSeconds,
    int? currentStreak,
    int? bestStreak,
  }) {
    return GameStatistics(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      bestScore: bestScore ?? this.bestScore,
      totalScore: totalScore ?? this.totalScore,
      bestCombo: bestCombo ?? this.bestCombo,
      totalPairsMatched: totalPairsMatched ?? this.totalPairsMatched,
      totalNumbersAdded: totalNumbersAdded ?? this.totalNumbersAdded,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gamesPlayed': gamesPlayed,
      'gamesWon': gamesWon,
      'bestScore': bestScore,
      'totalScore': totalScore,
      'bestCombo': bestCombo,
      'totalPairsMatched': totalPairsMatched,
      'totalNumbersAdded': totalNumbersAdded,
      'totalTimeSeconds': totalTimeSeconds,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
    };
  }

  factory GameStatistics.fromJson(Map<String, dynamic> json) {
    return GameStatistics(
      gamesPlayed: json['gamesPlayed'] as int? ?? 0,
      gamesWon: json['gamesWon'] as int? ?? 0,
      bestScore: json['bestScore'] as int? ?? 0,
      totalScore: json['totalScore'] as int? ?? 0,
      bestCombo: json['bestCombo'] as int? ?? 0,
      totalPairsMatched: json['totalPairsMatched'] as int? ?? 0,
      totalNumbersAdded: json['totalNumbersAdded'] as int? ?? 0,
      totalTimeSeconds: json['totalTimeSeconds'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      bestStreak: json['bestStreak'] as int? ?? 0,
    );
  }
}
