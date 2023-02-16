import 'package:flutter/material.dart';
import 'package:meet_up/screen/dashboard_screen/browse_screen.dart';
import 'package:meet_up/screen/dashboard_screen/dashboard_screen.dart';
import 'package:meet_up/screen/dashboard_screen/favorite_screen.dart';
import 'package:meet_up/screen/dashboard_screen/invitations_screen.dart';
import 'package:meet_up/screen/dashboard_screen/messages_screen.dart';
import 'package:meet_up/screen/dashboard_screen/mutual_like_screen.dart';
import 'package:meet_up/screen/dashboard_screen/qr_scanner_screen.dart';
import 'package:meet_up/screen/dashboard_screen/settings_screen.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:meet_up/screen/onboarding_screen/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/LoginScreen': (context) => LoginScreen(),
        '/MutualLikeScreen': (context) => MutualLikeScreen(),
        '/QrScannerScreen': (context) => QrScannerScreen(),
        '/MessageScreen': (context) => MessageScreen(),
        '/DashboardScreen': (context) => DashboardScreen(),
        '/BrowseScreen': (context) => BrowseScreen(),
        '/InvitationScreen': (context) => InvitationScreen(),
        '/SettingScreen': (context) => SettingScreen(),
        '/FavoriteScreen': (context) => FavoriteScreen(),
      },
      title: 'Meet Up',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingScreen(),
    );
  }
}
