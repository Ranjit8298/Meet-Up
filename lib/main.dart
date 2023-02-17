import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meet_up/screen/dashboard_screen/browse_screen.dart';
import 'package:meet_up/screen/dashboard_screen/dashboard_screen.dart';
import 'package:meet_up/screen/dashboard_screen/edit_profile_screen.dart';
import 'package:meet_up/screen/dashboard_screen/favorite_screen.dart';
import 'package:meet_up/screen/dashboard_screen/invitations_screen.dart';
import 'package:meet_up/screen/dashboard_screen/matches_user_screen.dart';
import 'package:meet_up/screen/dashboard_screen/messages_screen.dart';
import 'package:meet_up/screen/dashboard_screen/mutual_like_screen.dart';
import 'package:meet_up/screen/dashboard_screen/notifications_screen.dart';
import 'package:meet_up/screen/dashboard_screen/qr_scanner_screen.dart';
import 'package:meet_up/screen/dashboard_screen/settings_screen.dart';
import 'package:meet_up/screen/onboarding_screen/access_location_screen.dart';
import 'package:meet_up/screen/onboarding_screen/basic_information_screen.dart';
import 'package:meet_up/screen/onboarding_screen/checked_in_screen.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:meet_up/screen/onboarding_screen/onboarding_screen.dart';
import 'package:meet_up/screen/onboarding_screen/profile_image_choose_screen.dart';
import 'package:meet_up/screen/onboarding_screen/signup_screen.dart';

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
      useInheritedMediaQuery: true,
      // initialRoute: '/',
      routes: {
        // '/': (context) => OnboardingScreen(),
        '/CheckedInScreen': (context) => CheckedInScreen(),
        '/SignupScreen': (context) => SignupScreen(),
        '/BasicInformationSCreen': (context) => BasicInformationSCreen(),
        '/ProfileImageChooseScreen': (context) => ProfileImageChooseScreen(),
        '/AccessLocationScreen': (context) => AccessLocationScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/DashboardScreen': (context) => DashboardScreen(),
        '/QrScannerScreen': (context) => QrScannerScreen(),
        '/MessageScreen': (context) => MessageScreen(),
        '/MatchesUserScreen': (context) => MatchesUserScreen(),
        '/BrowseScreen': (context) => BrowseScreen(),
        '/FavoriteScreen': (context) => FavoriteScreen(),
        '/InvitationScreen': (context) => InvitationScreen(),
        '/MutualLikeScreen': (context) => MutualLikeScreen(),
        '/NotificationsScreen': (context) => NotificationsScreen(),
        '/SettingScreen': (context) => SettingScreen(),
        '/EditProfileScreen': (context) => EditProfileScreen(),
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
