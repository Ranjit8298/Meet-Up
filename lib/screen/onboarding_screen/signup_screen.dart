import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:meet_up/screen/onboarding_screen/otp_screen.dart';
import '../../widgets/custom_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController mobileNumberTxt = TextEditingController();
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  bool isValidForm = false;
  bool showLoder = true;
  bool callFirebaseFunction = true;
  var _verificationCode;
  String storedMobileNo = '';

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 ${mobileNumberTxt.text.toString()}',
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        var snackBar = SnackBar(content: Text(e.message.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.message);
      },
      codeSent: (verificationId, forceResendingToken) {
        setState(() {
          _verificationCode = verificationId;
          print(_verificationCode);
          // mobileNumberTxt.text = '';
          // _saveMobileNo();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return OtpScreen(
                mobileNumberTxt.text.toString(),
                _verificationCode.toString(),
              );
            },
          ));
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        // setState(() {
        //   _verificationCode = verificationId;
        // });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

//filter phone number from firebase firestore
  Future _filterMobileNoFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('user_mobileNo', isEqualTo: mobileNumberTxt.text.toString())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          storedMobileNo = doc["user_mobileNo"];
          print('storedMobileNo==> ${storedMobileNo}');
        });
      });
    });
  }

  emptyFunction() {}

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showLoder = false;
        // _filterMobileNoFromFirebase();
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
                              mobileNumberTxt.addListener(() {
                                if (mobileNumberTxt.text.length == 10) {
                                  _filterMobileNoFromFirebase();
                                }
                              });
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
                                            // _verifyPhone();
                                            if (storedMobileNo !=
                                                mobileNumberTxt.text
                                                    .toString()) {
                                              _verifyPhone();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "You are already register with us. Please login"),
                                                action: SnackBarAction(
                                                  label: 'LOGIN',
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/LoginScreen');
                                                  },
                                                ),
                                              ));
                                            }
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
