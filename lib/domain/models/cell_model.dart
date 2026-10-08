// Domain model representing a single cell on the Number Match board.

class CellModel {
  final int id;
  final int index;
  final int value;
  final bool isCleared;

  const CellModel({
    required this.id,
    required this.index,
    required this.value,
    this.isCleared = false,
  });

  CellModel copyWith({
    int? id,
    int? index,
    int? value,
    bool? isCleared,
  }) {
    return CellModel(
      id: id ?? this.id,
      index: index ?? this.index,
      value: value ?? this.value,
      isCleared: isCleared ?? this.isCleared,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'value': value,
      'isCleared': isCleared,
    };
  }

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
      id: json['id'] as int,
      index: json['index'] as int,
      value: json['value'] as int,
      isCleared: json['isCleared'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CellModel &&
        other.id == id &&
        other.index == index &&
        other.value == value &&
        other.isCleared == isCleared;
  }

  @override
  int get hashCode => Object.hash(id, index, value, isCleared);

  @override
  String toString() =>
      'Cell(id: $id, idx: $index, val: $value, cleared: $isCleared)';
}
