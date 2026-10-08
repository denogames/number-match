import 'cell_model.dart';

class BoardModel {
  static const int defaultColumns = 9;

  final int columns;
  final List<CellModel> cells;

  const BoardModel({
    this.columns = defaultColumns,
    required this.cells,
  });

  int get totalCells => cells.length;

  int get rowCount => cells.isEmpty ? 0 : ((cells.length + columns - 1) ~/ columns);

  int get remainingActiveCount => cells.where((c) => !c.isCleared).length;

  int get clearedCount => cells.where((c) => c.isCleared).length;

  bool get isClear => remainingActiveCount == 0 && cells.isNotEmpty;

  CellModel? getCell(int index) {
    if (index < 0 || index >= cells.length) return null;
    return cells[index];
  }

  CellModel? getCellAt(int row, int col) {
    if (row < 0 || col < 0 || col >= columns) return null;
    final index = row * columns + col;
    if (index >= cells.length) return null;
    return cells[index];
  }

  int rowOf(int index) => index ~/ columns;

  int colOf(int index) => index % columns;

  // Check if a specific row has all its existing cells cleared.
  // Note: Only completely full or existing rows with all cleared cells count.
  bool isRowFullyCleared(int row) {
    final start = row * columns;
    final end = (start + columns).clamp(0, cells.length);
    if (start >= cells.length) return false;
    for (int i = start; i < end; i++) {
      if (!cells[i].isCleared) return false;
    }
    return true;
  }

  // Returns list of fully cleared row indices.
  List<int> getFullyClearedRows() {
    final clearedRows = <int>[];
    for (int r = 0; r < rowCount; r++) {
      if (isRowFullyCleared(r)) {
        clearedRows.add(r);
      }
    }
    return clearedRows;
  }

  // Compact board by removing rows where all cells are cleared.
  // Preserves relative reading order of remaining cells.
  BoardModel compactEmptyRows() {
    final clearedRowSet = getFullyClearedRows().toSet();
    if (clearedRowSet.isEmpty) return this;

    final newCells = <CellModel>[];
    int newIndex = 0;

    for (int r = 0; r < rowCount; r++) {
      if (clearedRowSet.contains(r)) {
        // Skip entire row
        continue;
      }
      final start = r * columns;
      final end = (start + columns).clamp(0, cells.length);
      for (int i = start; i < end; i++) {
        newCells.add(cells[i].copyWith(index: newIndex));
        newIndex++;
      }
    }

    return BoardModel(
      columns: columns,
      cells: newCells,
    );
  }

  BoardModel copyWith({
    int? columns,
    List<CellModel>? cells,
  }) {
    return BoardModel(
      columns: columns ?? this.columns,
      cells: cells ?? this.cells,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'columns': columns,
      'cells': cells.map((c) => c.toJson()).toList(),
    };
  }

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    return BoardModel(
      columns: json['columns'] as int? ?? defaultColumns,
      cells: (json['cells'] as List<dynamic>)
          .map((c) => CellModel.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BoardModel) return false;
    if (other.columns != columns || other.cells.length != cells.length) {
      return false;
    }
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] != other.cells[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(columns, Object.hashAll(cells));
}
