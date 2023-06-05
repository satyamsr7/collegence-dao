import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/core/Palette.dart';
import 'package:collegence_dao/core/function.dart';

class PublicAddressSectionWidget extends StatelessWidget {
  const PublicAddressSectionWidget({super.key, this.col = Palette.neonGreen});
  final Color col;

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
        color: col,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: const Text(
          'Your Collegence Identity',
          style: TextStyle(color: Colors.blueGrey),
        ),
        subtitle: Consumer(builder: (context, ref, child) {
          final publicAddress = ref.watch(privateKey.notifier).publicAddress;
          final String address = shortAddress(publicAddress);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.blueGrey.shade600,
                ),
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
            Consumer(builder: (context, ref, child) {
              final publicAddress =
                  ref.watch(privateKey.notifier).publicAddress;
              final String address = shortAddress(publicAddress);
              return IconButton(
                onPressed: () {
                  if (publicAddress != null) {
                    saveToClipboard(publicAddress);
                    Toast(context, 'Copied $address');
                  }
                },
                icon: CircleAvatar(
                  backgroundColor: col == Palette.neonGreen
                      ? const Color.fromARGB(255, 136, 255, 0)
                      : Colors.grey.shade400,
                  child: const Icon(Icons.copy),
                ),
              );
            }),
            Consumer(builder: (context, ref, child) {
              final publicAddress =
                  ref.watch(privateKey.notifier).publicAddress;
              var gravatar = Gravatar(publicAddress ?? 'collegence_dao');
              var url = gravatar.imageUrl(
                size: 100,
                defaultImage: GravatarImage.retro,
                rating: GravatarRating.pg,
                fileExtension: true,
              );
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
