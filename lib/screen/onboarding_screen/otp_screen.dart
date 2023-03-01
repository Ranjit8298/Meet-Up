import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/basic_information_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  // const OtpScreen({super.key});

  var mobileNo;
  var _verificationCode;
  OtpScreen(this.mobileNo, this._verificationCode, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // late String _verificationCode;

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  String currentText = "";
  bool isError = false;
  bool showLoder = true;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

// function for verify OTP
  _verifyOtp() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: widget._verificationCode,
              smsCode: pinController.text.toString()))
          .then((value) {
        if (value.user != null) {
          _storeUserData();
          _saveMobileNo();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return BasicInformationSCreen();
            },
          ));
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      var snackBar = SnackBar(content: Text('Invalid OTP'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

// function for store data in sharedpreferences
  _storeUserData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('mobileNo', widget.mobileNo);
  }

  _saveMobileNo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('mobile_no', widget.mobileNo);
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 260,
                            height: 260,
                            margin: const EdgeInsets.only(top: 15),
                            child: Image.asset(
                              'assets/images/otp_ui.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 25, left: 10, bottom: 0),
                          child: const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, left: 10, bottom: 0),
                          child: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                const TextSpan(
                                    text: 'Enter the OTP sent to +91 '),
                                TextSpan(
                                    text: widget.mobileNo,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0.4))
                              ])),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          padding: EdgeInsets.all(8),
                          child: Form(
                            key: formKey,
                            child: Pinput(
                              length: 6,
                              pinAnimationType: PinAnimationType.fade,
                              focusNode: focusNode,
                              controller: pinController,
                              autofocus: true,
                              focusedPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              errorPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.redAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              defaultPinTheme: PinTheme(
                                width: 55,
                                height: 55,
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD3D3D3)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter OTP';
                                } else if (value.length < 6) {
                                  return 'Please enter correct OTP';
                                } else {
                                  return null;
                                }
                              },
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                              },
                              onSubmitted: (value) async {
                                _verifyOtp();
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 335,
                            height: 45,
                            margin: const EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                                onPressed: () {
                                  focusNode.unfocus();
                                  formKey.currentState!.validate();
                                  _verifyOtp();
                                },
                                child: const Text(
                                  'VERIFY & PROCEED',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.4,
                                      fontSize: 18),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Don't receive the OTP?"),
                              const Text(' '),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  'RESEND OTP',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.4,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
