import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/client/function.dart';
import 'package:collegence_dao/core/typedef.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

Future<List<dynamic>> getVoteStatus(BigInt id, Web3Client client) async {
  final response = await readFunction(
    args: [id],
    functionName: 'getVoteStatus',
    contractsType: Contracts.DAO,
    web3client: client,
  );
  return response;
}

Future<String?> castVote(
    {required BigInt id, required bool vote, required WidgetRef ref}) async {
  if (ref.read(privateKey) == null) {
    return 'NULL';
  }
  try {
    final response = await writeFunction(
      args: [id, vote],
      functionName: 'voteOnProposal',
      contractsType: Contracts.DAO,
      web3client: ref.read(web3Client),
      privateKey: ref.read(privateKey)!,
    );
    return response;
  } catch (e) {
    rethrow;
  }
}
