import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meet_up/screen/onboarding_screen/profile_image_choose_screen.dart';
import 'package:meet_up/widgets/custom_back_button.dart';
import 'package:meet_up/widgets/custom_data_input.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';

class BasicInformationSCreen extends StatefulWidget {
  @override
  State<BasicInformationSCreen> createState() => _BasicInformationSCreenState();
}

class _BasicInformationSCreenState extends State<BasicInformationSCreen> {
  @override
  void initState() {
    super.initState();
    dateTxt.text = "";
  }

  var firstNameTxt = TextEditingController();

  var emailTxt = TextEditingController();
  var dateTxt = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  var male_width = 80.0;
  var male_height = 80.0;
  bool male_flag = true;
  Color male_bgcolor = Colors.black;

  var female_width = 80.0;
  var female_height = 80.0;
  bool female_flag = true;
  Color female_bgcolor = Colors.black;

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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        margin: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/images/basic_info.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomTextFormField(
                        txtController: firstNameTxt,
                        onChanged: (firstNameTxt) {
                          print(firstNameTxt.text.toString());
                        },
                        hintText: 'Enter Your First Name',
                        prefixIcon: Icon(Icons.person_rounded),
                        labelText: 'First Name',
                        keyboardType: TextInputType.text,
                        validator: (firstNameTxt) {
                          if (firstNameTxt.toString().isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        txtController: emailTxt,
                        onChanged: (emailTxt) {
                          print(emailTxt.text.toString());
                        },
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(Icons.email_rounded),
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (emailTxt) {
                          if (emailTxt.toString().isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        }),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextField(
                          controller: dateTxt,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                            labelText: "Date",
                            // hintText: "Select Date",
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2004),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2004));
                            if (pickedDate != null) {
                              print(pickedDate);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);

                              setState(() {
                                dateTxt.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        'Select Gender',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            letterSpacing: 0.4,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (male_flag != true) {
                                  male_width = 80;
                                  male_height = 80;
                                  male_flag = true;
                                  male_bgcolor = Colors.black;
                                } else {
                                  male_width = 100;
                                  male_height = 100;
                                  male_flag = false;
                                  male_bgcolor = Colors.blue.shade900;

                                  female_width = 80;
                                  female_height = 80;
                                  female_flag = true;
                                  female_bgcolor = Colors.black;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              width: male_width,
                              height: male_width,
                              child: Image(
                                  fit: BoxFit.cover,
                                  color: male_bgcolor,
                                  image: AssetImage('assets/images/male.png')),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (female_flag != true) {
                                  female_width = 80;
                                  female_height = 80;
                                  female_flag = true;
                                  female_bgcolor = Colors.black;
                                } else {
                                  female_width = 100;
                                  female_height = 100;
                                  female_flag = false;
                                  female_bgcolor = Colors.green.shade900;

                                  male_width = 80;
                                  male_height = 80;
                                  male_flag = true;
                                  male_bgcolor = Colors.black;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              width: female_width,
                              height: female_height,
                              child: Image(
                                  fit: BoxFit.cover,
                                  color: female_bgcolor,
                                  image:
                                      AssetImage('assets/images/female.png')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 335,
                        height: 45,
                        margin: const EdgeInsets.only(top: 40, bottom: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ProfileImageChooseScreen();
                                },
                              ));
                            },
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.4,
                                  fontSize: 18),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
