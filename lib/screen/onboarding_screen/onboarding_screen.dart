import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_up/screen/onboarding_screen/checked_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool? isLoginCheck;
  bool showLoder = true;

  @override
  void initState() {
    super.initState();
    _getLoginState();
  }

  Future<void> _getLoginState() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoginCheck = prefs.getBool('isLogin')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
              bottom: true,
              top: true,
              left: true,
              right: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 370,
                    height: 400,
                    margin: const EdgeInsets.only(top: 60),
                    child: Lottie.asset('assets/row/hello.json'),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        "“That's the ideal meeting...once upon a time, only once, unexpectedly, then never again.”",
                        style: GoogleFonts.merriweather(
                            color: Color(0xFF850000),
                            letterSpacing: 0.3,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: 335,
                    height: 45,
                    margin: const EdgeInsets.only(top: 80),
                    child: ElevatedButton(
                        onPressed: () {
                          isLoginCheck == true
                              ? Navigator.pushNamed(
                                  context, '/AccessLocationScreen')
                              : Navigator.pushNamed(
                                  context, '/CheckedInScreen');
                        },
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.3,
                              fontSize: 18),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
