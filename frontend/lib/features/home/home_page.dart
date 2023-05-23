import 'package:collegence_dao/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/create_proposal_section.widget.dart';
import 'widgets/proposal_list_section.widget.dart';
import 'widgets/public_address_section.dart';
import 'widgets/stat_section.dart';

final navVisible = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.dartBackgroundColor,
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        return ref.watch(navVisible)
            ? const SizedBox(height: 0, width: 0)
            : NavigationBar(
                backgroundColor: Colors.transparent,
                selectedIndex: 1,
                height: 50,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: 'Person',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: 'Setting',
                  )
                ],
              );
      }),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: ListView(
            shrinkWrap: true,
            children: [
              //* APP BAR
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Collegence',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                foregroundColor: Colors.white,
                actions: [
                  Consumer(builder: (context, ref, child) {
                    return IconButton(
                        onPressed: () => ref
                            .read(navVisible.notifier)
                            .update((state) => !state),
                        icon: const Icon(Icons.menu));
                  })
                ],
              ),
              //* PUBLIC ADDRESS
              const PublicAddressSectionWidget(),
              //* STATS
              const StatSectionWidget(),
              //* PROPOSAL
              const ProposalListSection(),
              //* CREATE PROPOSAL SECTION
              const CreateProposalSection(),
              //***************************/
              const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                return ref.watch(navVisible)
                    ? NavigationBar(
                        backgroundColor: Colors.transparent,
                        selectedIndex: 1,
                        height: 50,
                        labelBehavior:
                            NavigationDestinationLabelBehavior.alwaysHide,
                        destinations: const [
                          NavigationDestination(
                            icon: Icon(Icons.person),
                            label: 'Person',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.home),
                            label: 'home',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.settings),
                            label: 'Setting',
                          )
                        ],
                      )
                    : const SizedBox(height: 0, width: 0);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
