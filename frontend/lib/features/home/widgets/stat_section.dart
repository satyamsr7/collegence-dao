import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:collegence_dao/core/Palette.dart';
import 'package:collegence_dao/features/home/controller/stats.controller.dart';

class StatSectionWidget extends StatelessWidget {
  const StatSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Stats',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Palette.dartBackgroundColor,
                ),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.grey),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.grey),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                icon: const Icon(Icons.line_axis),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                icon: const Icon(Icons.shape_line, color: Colors.white),
              ),
            ],
          ),
          Card(
            elevation: 0,
            child: ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              selectedColor: Colors.blue,
              leading: const Icon(Icons.format_list_numbered),
              title: const Text('Total Proposals'),
              subtitle: Consumer(
                builder: (context, ref, child) => FutureBuilder<String>(
                  future:
                      ref.watch(proposalStats.notifier).fetchProposalCount(),
                  builder: (context, snapshot) => Consumer(
                    builder: (context, ref, child) {
                      final String count = ref.watch(proposalStats
                              .select((value) => value.totalProposalCount)) ??
                          '0';
                      return Text(count);
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: -2),
                  tileColor: Colors.blue,
                  leading: const Icon(
                    Icons.thumb_up,
                    size: 25.0,
                    semanticLabel: 'Approved',
                  ),
                  title: const Text(' Approved'),
                  subtitle: Consumer(
                    builder: (context, ref, child) => FutureBuilder<String>(
                      future: ref
                          .watch(proposalStats.notifier)
                          .fetchApprovedProposalCount(),
                      builder: (context, snapshot) => Consumer(
                        builder: (context, ref, child) {
                          final String count = ref.watch(proposalStats
                                  .select((value) => value.approved)) ??
                              '0';
                          return Text(' $count');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: -2),
                  leading: const Icon(
                    Icons.thumb_down,
                    size: 25.0,
                    semanticLabel: 'Rejected',
                  ),
                  title: const Text('Ongoing'),
                  subtitle: Consumer(
                    builder: (context, ref, child) => FutureBuilder<String>(
                      future: ref
                          .watch(proposalStats.notifier)
                          .fetchOngoingProposalCount(),
                      builder: (context, snapshot) => Consumer(
                        builder: (context, ref, child) {
                          final String count = ref.watch(proposalStats
                                  .select((value) => value.ongoing)) ??
                              '0';
                          return Text(' $count');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
