// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:collegence_dao/features/home/widgets/public_address_section.dart';

class SettingScreen extends ConsumerStatefulWidget {
  static const String name = 'setting';
  static const String path = '/setting';
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset('assets/setting.json'),
            PublicAddressSectionWidget(
              col: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () async {
                const storage = FlutterSecureStorage();
                final pref = await SharedPreferences.getInstance();
                storage.deleteAll();
                pref.clear();
                context.go('/splash');
              },
              leading: PhosphorIcon(PhosphorIcons.bold.signOut),
              title: const Text('Log Out'),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'v 1.0.0',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
