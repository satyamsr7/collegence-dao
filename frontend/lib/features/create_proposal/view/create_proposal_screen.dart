import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegence_dao/features/address_book/address_book_screen.dart';
import 'package:collegence_dao/features/address_book/models/address.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:collegence_dao/core/core.dart';

class CreateProposalScreen extends StatefulWidget {
  static const String name = 'create-proposal';
  static const String path = '/create-proposal';
  const CreateProposalScreen({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  Set<String> address = {};
  Box addressBox = Hive.box('addressBox');
  int length = 0;

  @override
  void initState() {
    super.initState();
    addressBox = Hive.box('addressBox');
    setState(() {
      length = addressBox.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log.d('length => $length');
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 10),
                child: Row(
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
                    IconButton(
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        context.pushNamed(AddressBookScreen.name);
                      },
                      icon: const Icon(Icons.edit_note_rounded,
                          color: Colors.white),
                    ),
                    const Spacer(),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: widget.controller,
                        enableSuggestions: false,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
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
                      Container(
                        height: 500,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blueGrey),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: length == 0
                            ? const Center(
                                child: Text('Add Voter to Address Box'),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                itemCount: length,
                                itemBuilder: (context, index) {
                                  final Address data = addressBox.getAt(index);
                                  var gravatar = Gravatar(
                                      shortAddress(data.address) ??
                                          'collegence_dao');
                                  var url = gravatar.imageUrl(
                                    size: 100,
                                    defaultImage: GravatarImage.retro,
                                    rating: GravatarRating.pg,
                                    fileExtension: true,
                                  );
                                  bool value = false;
                                  return StatefulBuilder(
                                      builder: (context, newState) {
                                    return ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0),
                                      dense: true,
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: url,
                                          height: 40,
                                        ),
                                      ),
                                      title: Text(data.name),
                                      subtitle: Text(
                                          shortAddress(data.address, i: 4)),
                                      trailing: Checkbox(
                                        onChanged: (v) {
                                          newState(() {
                                            value = v ?? value;
                                            print(data.address);
                                          });
                                          if (value) {
                                            print(data.address);
                                            address.add(data.address);
                                          } else {
                                            print(data.address);
                                            address.remove(data.address);
                                          }
                                        },
                                        value: value,
                                      ),
                                    );
                                  });
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(color: Colors.pink.shade100),
                              ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(42),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          print(address.toList());
                          log.v(address);
                          log.wtf('true');
                        },
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
      ),
    );
  }
}
