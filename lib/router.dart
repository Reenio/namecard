import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namecard/ui/screens/home_screen.dart';
import 'package:namecard/ui/screens/profile_edit_screen.dart';
import 'package:namecard/ui/screens/qr_display_screen.dart';
import 'package:namecard/ui/screens/qr_scanner_screen.dart';
import 'package:namecard/ui/screens/namecard_details_screen.dart';
import 'package:namecard/ui/screens/nearby_screen.dart';
import 'package:namecard/models/namecard.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'edit-profile',
          builder: (context, state) => const ProfileEditScreen(),
        ),
        GoRoute(
          path: 'qr-display',
          builder: (context, state) => const QrDisplayScreen(),
        ),
        GoRoute(
          path: 'qr-scan',
          builder: (context, state) => const QrScannerScreen(),
        ),
        GoRoute(
          path: 'wallet/details',
          builder: (context, state) {
             final card = state.extra as Namecard;
             return NamecardDetailsScreen(card: card);
          },
        ),
        GoRoute(
          path: 'nearby',
          builder: (context, state) => const NearbyScreen(),
        ),
      ],
    ),
  ],
);
