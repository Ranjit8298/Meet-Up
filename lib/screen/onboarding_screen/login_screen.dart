import 'package:flutter/material.dart';
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
        width: double.infinity,
        height: double.infinity,
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
                    margin: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/login_ill.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 10),
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
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isValidForm = true;
                                  });
                                } else {
                                  setState(() {
                                    isValidForm = false;
                                  });
                                }
                              },
                              child: const Text(
                                'Login',
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
                          onTap: () {},
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
