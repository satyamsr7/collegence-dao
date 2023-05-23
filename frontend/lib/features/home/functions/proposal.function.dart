import 'package:collegence_dao/client/function.dart';
import 'package:collegence_dao/core/typedef.dart';
import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:web3dart/web3dart.dart';

Future<Proposal> fetchProposalById(int id, Web3Client client) async {
  final response = await readFunction(
    args: [BigInt.from(id)],
    contractsType: Contracts.DAO,
    functionName: 'Proposals',
    web3client: client,
  );
  print(response[0]);
  final proposal = Proposal.fromTuple(response);
  print('Gamer $id ' + proposal.toString());
  print(proposal.description);
  return proposal;
}
