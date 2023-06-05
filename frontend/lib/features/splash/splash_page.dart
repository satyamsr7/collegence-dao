import 'package:collegence_dao/client/client.dart';
import 'package:collegence_dao/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool newUser = false;
  @override
  void initState() {
    super.initState();
    ref.read(web3Client);
    init();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      const storage = FlutterSecureStorage();
      final pref = await SharedPreferences.getInstance();
      final private = await storage.read(key: 'privateKey');
      final logged = pref.getBool('logged') ?? false;
      if (logged && private != null) {
        ref.read(privateKey);
        log.d(private);
        ref.read(privateKey.notifier).setCredentials = private;
        context.goNamed('home');
      }
    } catch (e) {
      setState(() => newUser = true);
    }
    setState(() => newUser = true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                Text(
                  'New way to run your organization',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Transparent ▪ Decentralized ▪ Autonomous',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: newUser,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                      ),
                      onPressed: () => context.pushNamed('login'),
                      child: const Text('Sign In'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
