import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_up/screen/onboarding_screen/checked_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   Colors.white,
        //   Colors.white,
        //   Colors.white,
        //   Colors.red.shade100
        // ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const CheckedInScreen();
                                },
                              ));
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
