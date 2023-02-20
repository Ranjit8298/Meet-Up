import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:meet_up/screen/onboarding_screen/otp_screen.dart';

import '../../widgets/custom_textFormField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var mobileNumberTxt = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isValidForm = false;
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
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 260,
                              height: 260,
                              margin: const EdgeInsets.only(top: 15),
                              child: Image.asset(
                                'assets/images/sign_up_vector.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 25, left: 10, bottom: 10),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            txtController: mobileNumberTxt,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            prefixIcon: const Icon(Icons.mobile_friendly),
                            hintText: 'Enter Your Mobile Number',
                            labelText: 'Mobile Number',
                            onChanged: (mobileNumberTxt) {
                              print(mobileNumberTxt);
                            },
                            validator: (value) {
                              if (value!.toString().trim().isEmpty) {
                                return 'Please enter mobile number';
                              } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                  .hasMatch(value)) {
                                return 'Please enter correct mobile number';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(top: 60),
                              width: 335,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 45,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return OtpScreen(
                                                  mobileNumberTxt.text
                                                      .toString(),
                                                );
                                              },
                                            ));
                                          }
                                        },
                                        child: const Text(
                                          'GET OTP',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.3,
                                              fontSize: 18),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginScreen();
                                        },
                                      ));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 30),
                                        child: const Text(
                                          'Already a member?',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.3),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ),
    );
  }
}
