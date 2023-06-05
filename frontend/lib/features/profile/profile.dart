import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatelessWidget {
  static const name = 'ProfileScreen';
  static const path = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: LottieBuilder.asset('assets/nft-making.json'),
        ),
      ),
    );
  }
}
