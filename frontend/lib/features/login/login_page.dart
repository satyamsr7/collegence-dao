import 'package:collegence_dao/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff16132f),
              Color(0xff450f53),
            ], begin: Alignment.topRight, end: Alignment.centerLeft),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Card(),
              Lottie.asset(LottieFile.planet),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                      ),
                      onPressed: () {
                        context.goNamed('home');
                      },
                      child: const Text('Sign In'),
                    ),
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
