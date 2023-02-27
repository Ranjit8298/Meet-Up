import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_up/screen/onboarding_screen/access_location_screen.dart';
import 'package:meet_up/screen/onboarding_screen/signup_screen.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mobileNumberTxt = TextEditingController();
  var passwordTxt = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();
  bool isValidForm = false;
  bool isPass = true;
  bool showLoder = true;
  String storedMobileNo = '';

  _filterMobileNoFromFirebase() {
    return users
        .where('user_mobileNo', isEqualTo: mobileNumberTxt.text.toString())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        storedMobileNo = doc["user_mobileNo"];
        print('userdata==>${doc}');
      });
    });
  }

  _saveMobileNo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('mobile_no', mobileNumberTxt.text.toString());
    });
  }

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
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: SafeArea(
                left: true,
                top: true,
                right: true,
                bottom: true,
                child: Form(
                  key: _formKey,
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 260,
                                height: 260,
                                margin: const EdgeInsets.only(top: 15),
                                child: Image.asset(
                                  'assets/images/login_vector.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 25, left: 10, bottom: 10),
                              child: const Text(
                                'Login',
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
                              prefixIcon: const Icon(Icons.mobile_friendly),
                              hintText: 'Enter Your Mobile Number',
                              labelText: 'Mobile Number',
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              onChanged: (mobileNumberTxt) {
                                print(mobileNumberTxt);
                                _filterMobileNoFromFirebase();
                              },
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return 'Please enter mobile number';
                                } else if (!RegExp(
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(value)) {
                                  return 'Please enter correct mobile number';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            CustomTextFormField(
                              txtController: passwordTxt,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(Icons.password_rounded),
                              hintText: 'Enter Your Password',
                              labelText: 'Password',
                              passwordField: true,
                              textInputAction: TextInputAction.done,
                              onChanged: (passwordTxt) {
                                print(passwordTxt);
                              },
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return 'Please enter password';
                                } else if (value.toString().length <= 4) {
                                  return 'Please enter at least 4 digits any password';
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
                                              if (storedMobileNo ==
                                                  mobileNumberTxt.text
                                                      .toString()) {
                                                mobileNumberTxt.text = '';
                                                passwordTxt.text = '';
                                                _saveMobileNo();
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return AccessLocationScreen();
                                                  },
                                                ));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "You aren't register with us. Please signup"),
                                                  action: SnackBarAction(
                                                    label: 'SIGN UP',
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/SignupScreen');
                                                    },
                                                  ),
                                                ));
                                              }
                                            }
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
                                        margin: const EdgeInsets.only(left: 40),
                                        child: const Text(
                                          'Forgot Password',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.3),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account?"),
                                      const Text(' '),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const SignupScreen();
                                            },
                                          ));
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.3,
                                              color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
