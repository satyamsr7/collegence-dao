import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegence_dao/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:collegence_dao/features/proposal/controllers/function.dart';

class ProposalPage extends ConsumerStatefulWidget {
  const ProposalPage({required this.proposal, super.key});
  final Proposal proposal;

  @override
  ConsumerState<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends ConsumerState<ProposalPage> {
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
    BigInt voteUp = widget.proposal.votesUp;
    BigInt voteDown = widget.proposal.votesDown;
    final DateTime deadline = DateTime.fromMillisecondsSinceEpoch(
        widget.proposal.deadline.toInt() * 1000);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.blue,
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
                        Text('Deadline : ${deadline.toLocal().toString()}'),
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
                            backgroundColor: vote == null
                                ? Colors.grey.shade200
                                : (vote!
                                    ? Colors.green.shade100
                                    : Colors.red.shade100),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            if (vote == null) return;
                            try {
                              castVote(
                                  id: widget.proposal.id,
                                  vote: vote!,
                                  ref: ref);
                            } catch (e) {
                              log.v(e);
                              Toast(context, e.toString());
                            }
                            context.pop();
                          },
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
                    onPressed: () {
                      context.pop();
                    },
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
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Proposal By'),
                                      const Divider(),
                                      Text(
                                        shortAddress(
                                            widget.proposal.proposer.hex,
                                            i: 8),
                                      ),
                                      const SizedBox(height: 16),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child:
                                  CachedNetworkImage(imageUrl: url, height: 35),
                            ),
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
                  children: [
                    Flexible(
                      child: VoteMatricTile(
                        title: 'For',
                        voteCount: voteUp,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: VoteMatricTile(
                        title: 'Against',
                        voteCount: voteDown,
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
                    'Vote Status',
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
                  child: Consumer(builder: (context, ref, child) {
                    final client = ref.watch(web3Client);
                    return FutureBuilder<List<dynamic>>(
                        future: getVoteStatus(widget.proposal.id, client),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            final addressList = snapshot.data![0] as List;
                            final voteStatus = snapshot.data![1] as List;
                            return ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: Gravatar(shortAddress(
                                                  addressList
                                                      .elementAt(index)
                                                      .hex) +
                                              '@dao.com')
                                          .imageUrl(
                                        size: 100,
                                        defaultImage: GravatarImage.retro,
                                        rating: GravatarRating.pg,
                                        fileExtension: true,
                                      ),
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  title: Text(
                                    shortAddress(
                                        addressList.elementAt(index).hex),
                                  ),
                                  trailing: voteStatus.elementAt(index)
                                      ? const Icon(
                                          CupertinoIcons.tickets_fill,
                                          color: Colors.greenAccent,
                                        )
                                      : const Icon(CupertinoIcons.tickets),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: addressList.length,
                            );
                          }
                          return const Center(child: Text('404'));
                        });
                  }),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                margin: const EdgeInsets.all(0),
                color: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    deadline.toLocal().toString(),
                    style: const TextStyle(color: Colors.white70),
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
    required this.voteCount,
  });

  final String title;
  final BigInt voteCount;

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
              '${voteCount.toString()} vote',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
