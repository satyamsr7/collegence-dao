import 'package:collegence_dao/core/Palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProposalScreen extends StatefulWidget {
  static const String name = 'create-proposal';
  static const String path = '/create-proposal';
  const CreateProposalScreen({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                  ),
                  const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.pink,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: widget.controller,
                      enableSuggestions: false,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLength: 100,
                      minLines: 1,
                      maxLines: 7,
                      decoration: InputDecoration(
                        labelText: ' Proposal ',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        hintText: 'Write your proposal here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: ListView(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Create Proposal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
