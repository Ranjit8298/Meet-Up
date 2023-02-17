import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/screen/onboarding_screen/basic_information_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpScreen extends StatefulWidget {
  // const OtpScreen({super.key});

  var mobileNo;
  OtpScreen(this.mobileNo, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool isError = false;
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
              padding: const EdgeInsets.all(10),
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
                          child: PinCodeTextField(
                            length: 6,
                            obscureText: false,
                            cursorColor: Colors.red,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            textStyle: const TextStyle(fontSize: 15),
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 40,
                                fieldWidth: 40,
                                activeFillColor: Colors.transparent,
                                errorBorderColor: Colors.red,
                                inactiveColor: Colors.grey,
                                inactiveFillColor: Colors.transparent,
                                selectedFillColor: Colors.transparent,
                                selectedColor: Colors.green.shade900,
                                activeColor: Colors.green.shade900),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            // backgroundColor: Colors.blue.shade50,
                            enableActiveFill: true,
                            controller: textEditingController,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        isError == true
                            ? Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Please enter correct OTP',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                              )
                            : SizedBox(),
                        Center(
                          child: Container(
                            width: 335,
                            height: 45,
                            margin: const EdgeInsets.only(top: 40),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (currentText.length < 6) {
                                      isError = true;
                                    } else {
                                      isError = false;
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return BasicInformationSCreen();
                                        },
                                      ));
                                    }
                                  });
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
