import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                          'assets/images/sign_up_vector.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 25, left: 10, bottom: 10),
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
                      prefixIcon: const Icon(Icons.mobile_friendly),
                      suffixOnTap: () {},
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
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0.3,
                                        fontSize: 18),
                                  )),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 30),
                                child: const Text(
                                  'Already a member?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.3),
                                ))
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
