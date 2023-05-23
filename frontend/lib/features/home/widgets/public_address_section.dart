import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/core/function.dart';
import 'package:collegence_dao/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class PublicAddressSectionWidget extends StatelessWidget {
  const PublicAddressSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5).copyWith(
        bottom: 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Pallete.neonGreen,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: const Text(
          'Your Collegence Identity',
          style: TextStyle(color: Colors.blueGrey),
        ),
        subtitle: Consumer(builder: (context, ref, child) {
          final publicAddress = ref.watch(PrivateKey.notifier).publicAddress;
          final address = shortAddress(publicAddress);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address ?? '0x0000....0000',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              // FutureBuilder<EtherAmount?>(
              //   future: ref.watch(PrivateKey.notifier).balance,
              //   builder: (context, snapshot) => snapshot.hasData
              //       ? Text(snapshot.data?.getInWei.toString() ?? '')
              //       : const Text('Loading...'),
              // )
            ],
          );
        }),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 136, 255, 0),
                child: Icon(Icons.copy),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              final publicAddress =
                  ref.watch(PrivateKey.notifier).publicAddress;
              var gravatar = Gravatar(publicAddress ?? 'collegence_dao');
              var url = gravatar.imageUrl(
                size: 100,
                defaultImage: GravatarImage.retro,
                rating: GravatarRating.pg,
                fileExtension: true,
              );
              print(url);
              return ClipOval(
                child: CachedNetworkImage(imageUrl: url, height: 35),
              );
            }),
          ],
        ),
      ),
    );
  }
}
