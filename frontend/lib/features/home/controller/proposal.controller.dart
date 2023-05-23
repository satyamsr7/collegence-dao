import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProposalNotifier extends StateNotifier<Map<int, Proposal>> {
  Ref ref;
  ProposalNotifier(this.ref) : super({});
}
