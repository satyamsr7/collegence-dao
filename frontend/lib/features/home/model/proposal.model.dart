// ignore_for_file: public_member_api_docs, sort_constructors_first

class Proposal {
  final BigInt id;
  final bool exists;
  final String description;
  final BigInt deadline;
  final BigInt votesUp;
  final BigInt votesDown;
  final BigInt maxVotes;
  final bool countConducted;
  final bool passed;
  Proposal({
    required this.id,
    required this.exists,
    required this.description,
    required this.deadline,
    required this.votesUp,
    required this.votesDown,
    required this.maxVotes,
    required this.countConducted,
    required this.passed,
  });

  Proposal copyWith({
    BigInt? id,
    bool? exists,
    String? description,
    BigInt? deadline,
    BigInt? votesUp,
    BigInt? votesDown,
    BigInt? maxVotes,
    bool? countConducted,
    bool? passed,
  }) {
    return Proposal(
      id: id ?? this.id,
      exists: exists ?? this.exists,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      votesUp: votesUp ?? this.votesUp,
      votesDown: votesDown ?? this.votesDown,
      maxVotes: maxVotes ?? this.maxVotes,
      countConducted: countConducted ?? this.countConducted,
      passed: passed ?? this.passed,
    );
  }

  factory Proposal.fromTuple(List<dynamic> tuple) {
    return Proposal(
      id: tuple[0],
      exists: tuple[1] ?? false,
      description: tuple[2] as String,
      deadline: tuple[3],
      votesUp: tuple[4],
      votesDown: tuple[5],
      maxVotes: tuple[6],
      countConducted: tuple[7] ?? false,
      passed: tuple[8] ?? false,
    );
  }

  @override
  String toString() {
    return 'Proposal(id: $id, exists: $exists, description: $description, deadline: $deadline, votesUp: $votesUp, votesDown: $votesDown, maxVotes: $maxVotes, countConducted: $countConducted, passed: $passed)';
  }

  @override
  bool operator ==(covariant Proposal other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.exists == exists &&
        other.description == description &&
        other.deadline == deadline &&
        other.votesUp == votesUp &&
        other.votesDown == votesDown &&
        other.maxVotes == maxVotes &&
        other.countConducted == countConducted &&
        other.passed == passed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        exists.hashCode ^
        description.hashCode ^
        deadline.hashCode ^
        votesUp.hashCode ^
        votesDown.hashCode ^
        maxVotes.hashCode ^
        countConducted.hashCode ^
        passed.hashCode;
  }
}
