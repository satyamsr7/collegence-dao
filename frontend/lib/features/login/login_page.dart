import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/core/core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff16132f),
              Color(0xff450f53),
            ], begin: Alignment.topRight, end: Alignment.centerLeft),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset(LottieFile.planet, width: size.width * 0.7),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome To DAO!',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: controller,
                      style: GoogleFonts.poppins(color: Colors.white),
                      enableSuggestions: false,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        constraints: BoxConstraints.tight(
                          const Size.fromHeight(55),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        suffixIcon: const Icon(Icons.arrow_forward),
                        hintText: 'Private Key',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Consumer(builder: (context, ref, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(42),
                        ),
                        onPressed: () async {
                          if (controller.text.isEmpty) {
                            Toast(context, 'Empty field');
                            return;
                          }
                          if (!controller.text.startsWith('0x') &&
                              controller.text.trim().length < 66) {
                            if (controller.text.isEmpty) {
                              Toast(context, 'Enter Valid private address');
                              return;
                            }
                            return;
                          }
                          const storage = FlutterSecureStorage();
                          storage.write(
                              key: 'privateKey', value: controller.text);
                          final pref = await SharedPreferences.getInstance();
                          await pref.setBool('logged', true);
                          try {
                            ref.read(privateKey.notifier).setCredentials =
                                controller.text.trim();
                            context.goNamed('home');
                          } catch (e) {
                            Toast(context, 'Some error occured');
                          }
                        },
                        child: const Text('Sign In'),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
