// Model representing a pair of matching cells on the board.

enum MatchReason {
  none,
  sameValue,
  sumTen,
}

class MatchPair {
  final int indexA;
  final int indexB;
  final MatchReason reason;

  const MatchPair({
    required this.indexA,
    required this.indexB,
    this.reason = MatchReason.none,
  });

  bool contains(int index) => index == indexA || index == indexB;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MatchPair &&
        ((other.indexA == indexA && other.indexB == indexB) ||
            (other.indexA == indexB && other.indexB == indexA));
  }

  @override
  int get hashCode => indexA < indexB
      ? Object.hash(indexA, indexB)
      : Object.hash(indexB, indexA);

  @override
  String toString() =>
      'MatchPair($indexA <-> $indexB, reason: ${reason.name})';
}
