import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/core/pallete.dart';
import 'package:collegence_dao/features/home/functions/proposal.function.dart';
import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collegence_dao/features/home/controller/stats.controller.dart';
import 'package:go_router/go_router.dart';
import 'package:web3dart/web3dart.dart';

class ProposalListSection extends StatelessWidget {
  const ProposalListSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Pallete.blue,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Proposals',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Consumer(builder: (context, ref, child) {
              final count = ref.watch(
                  ProposalStats.select((value) => value.totalProposalCount));
              int len = int.tryParse(count ?? '') ?? 0;
              return ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: len > 5 ? 5 : len,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Consumer(builder: (context, ref, child) {
                    final client = ref.watch(web3Client);
                    return FutureBuilder<Proposal>(
                      future: fetchProposalById(len - index, client),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var proposal = snapshot.data!;
                          final exists = proposal.exists;
                          final passed = proposal.passed;
                          return ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () => context.goNamed(
                              'proposal',
                              extra: proposal,
                              pathParameters: {'id': proposal.id.toString()},
                            ),
                            leading: Chip(
                              padding: const EdgeInsets.all(1),
                              label: Text(proposal.id.toString()),
                            ),
                            title: Text(
                              proposal.description.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            subtitle: const Text(
                              '0x1234....23457',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Builder(builder: (context) {
                                  if (!exists && passed) {
                                    return const Icon(
                                      Icons.add_task_rounded,
                                      color: Colors.green,
                                    );
                                  } else if (exists && !passed) {
                                    return const Icon(
                                      Icons.block_rounded,
                                      color: Colors.red,
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.play_arrow,
                                      color: Colors.blue,
                                    );
                                  }
                                }),
                              ),
                            ),
                          );
                        } else {
                          return const Text('Loading...');
                        }
                      },
                    );
                  });
                  return ListTile(
                    visualDensity: const VisualDensity(vertical: -4),
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Gamer ${len - index}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      '0x1234....23457',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
