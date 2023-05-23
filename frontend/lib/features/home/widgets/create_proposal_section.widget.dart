import 'package:collegence_dao/core/pallete.dart';
import 'package:flutter/material.dart';

class CreateProposalSection extends StatelessWidget {
  const CreateProposalSection({
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
        color: Pallete.pink,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Create',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.pinkAccent,
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
          TextField(
            style: const TextStyle(color: Colors.white),
            enableSuggestions: false,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLength: 100,
            minLines: 1,
            maxLines: 7,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: 'Write your proposal here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              hintStyle: const TextStyle(color: Colors.blueGrey),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(42),
              foregroundColor: Colors.white,
              backgroundColor: Colors.pinkAccent,
            ),
            onPressed: () {},
            child: const Text(
              'Create Proposal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
