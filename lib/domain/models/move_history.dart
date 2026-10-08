import 'cell_model.dart';

// Snapshot of game state before a move, used for undo operations.
class MoveHistory {
  final List<CellModel> previousCells;
  final int previousScore;
  final int previousCombo;
  final int previousMatchesCount;
  final int previousAddsCount;
  final String actionDescription;

  const MoveHistory({
    required this.previousCells,
    required this.previousScore,
    required this.previousCombo,
    required this.previousMatchesCount,
    required this.previousAddsCount,
    required this.actionDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'previousCells': previousCells.map((c) => c.toJson()).toList(),
      'previousScore': previousScore,
      'previousCombo': previousCombo,
      'previousMatchesCount': previousMatchesCount,
      'previousAddsCount': previousAddsCount,
      'actionDescription': actionDescription,
    };
  }

  factory MoveHistory.fromJson(Map<String, dynamic> json) {
    return MoveHistory(
      previousCells: (json['previousCells'] as List<dynamic>)
          .map((c) => CellModel.fromJson(c as Map<String, dynamic>))
          .toList(),
      previousScore: json['previousScore'] as int? ?? 0,
      previousCombo: json['previousCombo'] as int? ?? 1,
      previousMatchesCount: json['previousMatchesCount'] as int? ?? 0,
      previousAddsCount: json['previousAddsCount'] as int? ?? 0,
      actionDescription: json['actionDescription'] as String? ?? '',
    );
  }
}
