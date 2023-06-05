// ignore_for_file: constant_identifier_names

import 'package:web3dart/web3dart.dart';

import '../client/function.dart';

enum Contracts { NFT, DAO }

extension FunctionalityExtension on Contracts {
  Future<DeployedContract> get deployedContract async {
    switch (this) {
      case Contracts.NFT:
        return await nftContract;
      case Contracts.DAO:
        return await daoContract;
    }
  }
}
