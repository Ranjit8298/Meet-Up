import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meet_up/screen/onboarding_screen/checked_in_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.red.shade100
        ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
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
                      child: const Text(
                        textAlign: TextAlign.center,
                        "“That's the ideal meeting...once upon a time, only once, unexpectedly, then never again.”",
                        style: TextStyle(
                            color:Color(0xFF850000),
                            fontFamily: 'Poppins',
                            letterSpacing: 0.3,
                            fontSize: 16),
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
                          'Get Started',
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