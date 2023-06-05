import 'package:collegence_dao/features/create_proposal/view/create_proposal_screen.dart';
import 'package:collegence_dao/features/home/home_page.dart';
import 'package:collegence_dao/features/home/model/proposal.model.dart';
import 'package:collegence_dao/features/login/login_page.dart';
import 'package:collegence_dao/features/profile/profile.dart';
import 'package:collegence_dao/features/proposal/views/pages/proposal_page.dart';
import 'package:collegence_dao/features/settings/settings.dart';
import 'package:collegence_dao/features/splash/splash_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: CreateProposalScreen.path,
      name: CreateProposalScreen.name,
      builder: (context, state) => CreateProposalScreen(
        controller: state.extra as TextEditingController,
      ),
    ),
    GoRoute(
      path: ProfileScreen.path,
      name: ProfileScreen.name,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: SettingScreen.path,
      name: SettingScreen.name,
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/proposal/:id',
      name: 'proposal',
      builder: (context, state) => ProposalPage(
        proposal: state.extra as Proposal,
      ),
    ),
  ],
);
