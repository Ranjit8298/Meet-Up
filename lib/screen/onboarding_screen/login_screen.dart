import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/access_location_screen.dart';
import 'package:meet_up/screen/onboarding_screen/signup_screen.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mobileNumberTxt = TextEditingController();
  var passwordTxt = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isValidForm = false;
  bool isPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.white,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white24,
          Colors.blue.shade50,
          Colors.red.shade300
        ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
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
                      'assets/images/login_vector.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 10, bottom: 10),
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
                  onChanged: (mobileNumberTxt) {
                    print(mobileNumberTxt);
                  },
                  validator: (mobileNumberTxt) {
                    if (mobileNumberTxt.toString().isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  txtController: passwordTxt,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.password_rounded),
                  suffixIcon: isPass == true
                      ? Icon(Icons.visibility_off_rounded)
                      : Icon(Icons.visibility),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
                  onChanged: (passwordTxt) {
                    print(passwordTxt);
                  },
                  validator: (passwordTxt) {
                    if (passwordTxt.toString().isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
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
                                // if (_formKey.currentState!.validate()) {
                                //   setState(() {
                                //     isValidForm = true;
                                //   });
                                // } else {
                                //   setState(() {
                                //     isValidForm = false;
                                //   });
                                // }
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AccessLocationScreen();
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
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const Text(' '),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
