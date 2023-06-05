import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'package:collegence_dao/core/core.dart';

Future<DeployedContract> loadContract(
    String contractAddress, String contractName, String location) async {
  String abi = await rootBundle.loadString(location);
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, contractName),
    EthereumAddress.fromHex(contractAddress),
  );
  return contract;
}

final nftContract = FutureProvider(
    (ref) => loadContract(ENV.nftContract, 'Collegence', 'asset/IERC721.json'));

final daoContract = FutureProvider(
    (ref) => loadContract(ENV.nftContract, 'Collegence', 'asset/IDao.json'));

final web3Client = Provider((ref) {
  var httpClient = Client();
  return Web3Client(ENV.rpcURL, httpClient);
});

final privateKey = StateNotifierProvider<PrivateKeyProvider, EthPrivateKey?>(
    (ref) => PrivateKeyProvider(ref));

class PrivateKeyProvider extends StateNotifier<EthPrivateKey?> {
  final Ref ref;
  EtherAmount? bal;
  PrivateKeyProvider(this.ref) : super(null) {
    setCredentials = '0x';
  }

  set setCredentials(String privateKey) {
    state = EthPrivateKey.fromHex(privateKey);
    log.d(state);
  }

  String? get publicAddress {
    return state?.address.hex;
  }

  Future<EtherAmount?> get balance async {
    final client = ref.read(web3Client);
    if (state == null) return null;
    return bal = await client.getBalance(state!.address);
  }

  Future<EtherAmount?> get balanceInString async {
    final client = ref.read(web3Client);
    if (state == null) return null;
    return await client.getBalance(state!.address);
  }
}
