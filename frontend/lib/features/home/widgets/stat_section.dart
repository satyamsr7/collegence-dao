import 'package:collegence_dao/core/pallete.dart';
import 'package:collegence_dao/features/home/controller/stats.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                  color: Pallete.dartBackgroundColor,
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
              leading: PhosphorIcon(
                PhosphorIcons.fill.listNumbers,
                size: 25.0,
                semanticLabel: 'New Note',
              ),
              title: const Text('Total Proposals'),
              subtitle: Consumer(
                builder: (context, ref, child) => FutureBuilder<String>(
                  future:
                      ref.watch(ProposalStats.notifier).fetchProposalCount(),
                  builder: (context, snapshot) => Consumer(
                    builder: (context, ref, child) {
                      final String count = ref.watch(ProposalStats.select(
                              (value) => value.totalProposalCount)) ??
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
                  visualDensity: VisualDensity(vertical: -2),
                  tileColor: Colors.blue,
                  leading: PhosphorIcon(
                    PhosphorIcons.bold.thumbsUp,
                    size: 25.0,
                    semanticLabel: 'Approved',
                  ),
                  title: const Text(' Approved'),
                  subtitle: Consumer(
                    builder: (context, ref, child) => FutureBuilder<String>(
                      future: ref
                          .watch(ProposalStats.notifier)
                          .fetchApprovedProposalCount(),
                      builder: (context, snapshot) => Consumer(
                        builder: (context, ref, child) {
                          final String count = ref.watch(ProposalStats.select(
                                  (value) => value.approved)) ??
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
                  leading: PhosphorIcon(
                    PhosphorIcons.bold.thumbsDown,
                    size: 25.0,
                    semanticLabel: 'Approved',
                  ),
                  title: const Text('Ongoing'),
                  subtitle: Consumer(
                    builder: (context, ref, child) => FutureBuilder<String>(
                      future: ref
                          .watch(ProposalStats.notifier)
                          .fetchOngoingProposalCount(),
                      builder: (context, snapshot) => Consumer(
                        builder: (context, ref, child) {
                          final String count = ref.watch(ProposalStats.select(
                                  (value) => value.ongoing)) ??
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
