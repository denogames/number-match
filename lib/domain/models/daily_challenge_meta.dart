class DailyChallengeMeta {
  final String dateKey; // YYYY-MM-DD
  final bool isCompleted;
  final int score;
  final int moves;
  final int elapsedSeconds;
  final DateTime? completedAt;

  const DailyChallengeMeta({
    required this.dateKey,
    this.isCompleted = false,
    this.score = 0,
    this.moves = 0,
    this.elapsedSeconds = 0,
    this.completedAt,
  });

  DailyChallengeMeta copyWith({
    String? dateKey,
    bool? isCompleted,
    int? score,
    int? moves,
    int? elapsedSeconds,
    DateTime? completedAt,
  }) {
    return DailyChallengeMeta(
      dateKey: dateKey ?? this.dateKey,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      moves: moves ?? this.moves,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateKey': dateKey,
      'isCompleted': isCompleted,
      'score': score,
      'moves': moves,
      'elapsedSeconds': elapsedSeconds,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory DailyChallengeMeta.fromJson(Map<String, dynamic> json) {
    return DailyChallengeMeta(
      dateKey: json['dateKey'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      score: json['score'] as int? ?? 0,
      moves: json['moves'] as int? ?? 0,
      elapsedSeconds: json['elapsedSeconds'] as int? ?? 0,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}
