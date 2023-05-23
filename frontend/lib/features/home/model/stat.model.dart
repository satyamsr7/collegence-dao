// ignore_for_file: public_member_api_docs, sort_constructors_first
class Stats {
  final String? totalProposalCount;
  final String? approved;
  final String? ongoing;

  Stats(this.totalProposalCount, this.approved, this.ongoing);

  Stats copyWith({
    String? totalProposalCount,
    String? approved,
    String? ongoing,
  }) {
    return Stats(
      totalProposalCount ?? this.totalProposalCount,
      approved ?? this.approved,
      ongoing ?? this.ongoing,
    );
  }
}
