// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:web3dart/web3dart.dart';

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
  final EthereumAddress proposer;

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
    required this.proposer,
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
    EthereumAddress? proposer,
  }) {
    return Proposal(
      proposer: proposer ?? this.proposer,
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
      proposer: tuple[0] as EthereumAddress,
      id: tuple[1],
      exists: tuple[2] ?? false,
      description: tuple[3] as String,
      deadline: tuple[4],
      votesUp: tuple[5],
      votesDown: tuple[6],
      maxVotes: tuple[7],
      countConducted: tuple[8] ?? false,
      passed: tuple[9] ?? false,
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
