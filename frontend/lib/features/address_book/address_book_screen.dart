import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegence_dao/core/core.dart';
import 'package:collegence_dao/features/address_book/models/address.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:web3dart/web3dart.dart';

class AddressBookScreen extends StatefulWidget {
  static const String name = 'addressbook';
  static const String path = '/addressbook';

  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  int size = 0;

  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('addressBox');
    size = box.length;
    setState(() {});
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      title: const Text('Address Book'),
      actions: [
        IconButton(
          onPressed: () async {
            await box.clear();
            setState(() {});
          },
          icon: const Icon(Icons.delete),
        )
      ],
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          name.text = '';
          address.text = '';
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0).copyWith(
                  bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
                  top: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: address,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffeaddff),
                      ),
                      onPressed: () async {
                        try {
                          EthereumAddress.fromHex(address.text);
                          await box.add(Address(
                            name: name.text,
                            address: address.text,
                          ));
                          setState(() {
                            size++;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString().contains(
                                      'Must be a hex string with a length of 40')
                                  ? 'Must be a hex string with a length of 40'
                                  : 'Something went wrong'),
                            ),
                          );
                        }
                        context.pop();
                      },
                      child: const Text('ADD'),
                    )
                  ],
                ),
              );
            },
          );
          await Future.delayed(const Duration(milliseconds: 200));
        },
        child: const Icon(Icons.add),
      ),
      appBar: appbar,
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: Container(
          height:
              MediaQuery.of(context).size.height - appbar.preferredSize.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: size,
            itemBuilder: (context, index) {
              final Address data = box.getAt(index);
              var gravatar =
                  Gravatar(shortAddress(data.address) ?? 'collegence_dao');
              var url = gravatar.imageUrl(
                size: 100,
                defaultImage: GravatarImage.retro,
                rating: GravatarRating.pg,
                fileExtension: true,
              );
              return Dismissible(
                key: Key(index.toString()),
                background: Container(color: Colors.red),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  box.deleteAt(index);
                  setState(() => size--);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${data.name} removed")));
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      height: 40,
                    ),
                  ),
                  title: Text(data.name),
                  subtitle: Text(shortAddress(data.address, i: 6)),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      name.text = box.getAt(index).name;
                      address.text = box.getAt(index).address;
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0).copyWith(
                              bottom:
                                  20 + MediaQuery.of(context).viewInsets.bottom,
                              top: 30,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: address,
                                  decoration: const InputDecoration(
                                    labelText: 'Address',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffeaddff),
                                  ),
                                  onPressed: () async {
                                    try {
                                      EthereumAddress.fromHex(address.text);
                                      await box.putAt(
                                        index,
                                        Address(
                                          name: name.text,
                                          address: address.text,
                                        ),
                                      );
                                      setState(() {});
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Must be a hex string with a length of 40')),
                                      );
                                    }
                                    context.pop();
                                  },
                                  child: const Text('Proceed'),
                                )
                              ],
                            ),
                          );
                        },
                      );
                      await Future.delayed(const Duration(milliseconds: 200));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
