import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/client/function.dart';
import 'package:collegence_dao/core/typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/stat.model.dart';

final proposalStats = StateNotifierProvider<TotalProposalNotifier, Stats>(
    (ref) => TotalProposalNotifier(ref));

class TotalProposalNotifier extends StateNotifier<Stats> {
  final Ref ref;
  TotalProposalNotifier(this.ref) : super(Stats('0', '0', '0')) {
    fetchProposalCount();
  }

  Future<String> fetchProposalCount() async {
    final response = await readFunction(
      args: [],
      contractsType: Contracts.DAO,
      functionName: 'getProposalCount',
      web3client: ref.read(web3Client),
    );
    final count = response[0].toString();
    state = state.copyWith(totalProposalCount: count);
    return count;
  }

  Future<String> fetchApprovedProposalCount() async {
    final response = await readFunction(
      args: [],
      contractsType: Contracts.DAO,
      functionName: 'getProposalPassedCount',
      web3client: ref.read(web3Client),
    );
    final count = response[0].toString();
    state = state.copyWith(approved: count);
    return count;
  }

  Future<String> fetchOngoingProposalCount() async {
    final response = await readFunction(
      args: [],
      contractsType: Contracts.DAO,
      functionName: 'getOngoingProposalCount',
      web3client: ref.read(web3Client),
    );
    final count = response[0].toString();
    state = state.copyWith(ongoing: count);
    return count;
  }
}
