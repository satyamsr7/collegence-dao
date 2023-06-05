import 'package:collegence_dao/core/env.dart';
import 'package:collegence_dao/core/typedef.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> get nftContract async {
  String abi = await rootBundle.loadString('assets/IERC721.json');
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'Collegence'),
    EthereumAddress.fromHex(ENV.nftContract, enforceEip55: true),
  );
  return contract;
}

Future<DeployedContract> get daoContract async {
  String abi = await rootBundle.loadString('assets/IDao.json');
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'Dao'),
    EthereumAddress.fromHex(ENV.doaContract),
  );
  return contract;
}

Future<List<dynamic>> readFunction({
  required String functionName,
  List<dynamic>? args,
  required Contracts contractsType,
  required Web3Client web3client,
}) async {
  args = args ?? [];
  final contract = await contractsType.deployedContract;
  final ethFunction = contract.function(functionName);
  final result = await web3client.call(
      contract: contract, function: ethFunction, params: args);
  if (kDebugMode) {
    print("$functionName => $result");
  }
  return result;
}

Future<String> writeFunction({
  required String functionName,
  required List<dynamic> args,
  required Contracts contractsType,
  required EthPrivateKey privateKey,
  required Web3Client web3client,
  int maxGas = 100000,
}) async {
  try {
    final contract = await contractsType.deployedContract;
    final ethFunction = contract.function(functionName);
    Transaction transaction = Transaction.callContract(
      contract: contract,
      function: ethFunction,
      parameters: args,
      maxGas: maxGas,
    );
    final result =
        await web3client.sendTransaction(privateKey, transaction, chainId: 1);
    return result;
  } catch (e) {
    rethrow;
  }
}
