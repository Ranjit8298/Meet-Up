import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:meet_up/screen/onboarding_screen/signup_screen.dart';

class CheckedInScreen extends StatefulWidget {
  const CheckedInScreen({super.key});

  @override
  State<CheckedInScreen> createState() => _CheckedInScreenState();
}

class _CheckedInScreenState extends State<CheckedInScreen> {
  bool showLoder = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showLoder = false;
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: showLoder == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //   Colors.blue.shade200,
              //   Colors.white,
              //   Colors.white70,
              //   Colors.black
              // ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
              child: SingleChildScrollView(
                child: SafeArea(
                  bottom: true,
                  top: true,
                  left: true,
                  right: true,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: const Text(
                            'Checked In',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                letterSpacing: 0.3),
                          )),
                      const Text(
                        'Flirt, chat and meet people around you',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.3),
                      ),
                      Container(
                        width: 370,
                        height: 380,
                        margin: const EdgeInsets.only(top: 90),
                        child: const Image(
                          image: AssetImage('assets/images/checked_in.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 335,
                        height: 45,
                        margin: const EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return const LoginScreen();
                                    },
                                  ));
                            },
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.3,
                                  fontSize: 18),
                            )),
                      ),
                      Container(
                        width: 335,
                        height: 45,
                        // color: Colors.blue.shade900,
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3D1766),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return const SignupScreen();
                                    },
                                  ));
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.3,
                                  fontSize: 18),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
