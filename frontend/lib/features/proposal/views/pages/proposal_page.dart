import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegence_dao/core/pallete.dart';
import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({required this.proposal, super.key});
  final Proposal proposal;

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  @override
  Widget build(BuildContext context) {
    final passed = widget.proposal.passed;
    final exists = widget.proposal.exists;
    String status = 'Ongoing';
    Color col = Colors.blue;
    if (!exists && passed) {
      status = 'Passed';
      col = Colors.green;
    } else if (!exists && !passed) {
      status = 'Rejected';
      col = Colors.red;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.blue,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool? vote;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: StatefulBuilder(
                  builder: (context, newState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('CAST VOTE'),
                        const Divider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                              onTap: () {
                                if (vote != true) {
                                  vote = true;
                                } else {
                                  vote = null;
                                }
                                newState(() {});
                              },
                              leading: vote == true
                                  ? const Icon(Icons.radio_button_checked)
                                  : const Icon(Icons.radio_button_off_rounded),
                              title: const Text('FOR'),
                            ),
                            ListTile(
                              onTap: () {
                                if (vote != false) {
                                  vote = false;
                                } else {
                                  vote = null;
                                }
                                newState(() {});
                              },
                              leading: vote == false
                                  ? const Icon(Icons.radio_button_checked)
                                  : const Icon(Icons.radio_button_off_rounded),
                              title: const Text('AGAINST'),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.green.shade100,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: const Text('Proceed'),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (vote != null) {
                              vote = null;
                              newState(() {});
                            } else {
                              context.pop();
                            }
                          },
                          child: Text(vote != null ? 'Cancel' : 'Close'),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.line_axis_rounded, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(40, 40),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: 'P',
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'ROPOSAL ',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(text: widget.proposal.id.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.proposal.description,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Chip(
                      backgroundColor: col.withOpacity(0.2),
                      label: Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: col,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Proposed By  ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        var url = Gravatar('0x12349858477493').imageUrl(
                          size: 100,
                          defaultImage: GravatarImage.retro,
                          rating: GravatarRating.pg,
                          fileExtension: true,
                        );
                        print(url);
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child:
                                CachedNetworkImage(imageUrl: url, height: 35),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12)
                      .copyWith(top: 10),
                  child: const Text(
                    'Stats',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: VoteMatricTile(
                        title: 'For',
                        percentage: 75,
                        voteCount: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: VoteMatricTile(
                        title: 'Against',
                        percentage: 25,
                        voteCount: 4,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 20),
                  child: const Text(
                    'Cast Vote',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, newState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.radio_button_off_rounded),
                                label: const Text('For'),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.radio_button_off_rounded),
                                label: const Text('Against'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoteMatricTile extends StatelessWidget {
  const VoteMatricTile({
    super.key,
    required this.title,
    required this.percentage,
    required this.voteCount,
  });

  final String title;
  final double percentage;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '${percentage.toStringAsFixed(0)} %',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              voteCount.toString(),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: LinearProgressIndicator(
                value: (percentage / 100),
                color: Colors.blue,
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
