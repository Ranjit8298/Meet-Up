import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meet_up/screen/onboarding_screen/profile_image_choose_screen.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var genderTxt = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  bool isError = false;
  bool showLoder = true;

  _storeUserData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', firstNameTxt.text.toString());
    prefs.setString('emailAddress', emailTxt.text.toString());
    prefs.setString('dob', dateTxt.text.toString());
    prefs.setString('gender', genderTxt.text.toString());
  }

  @override
  void dispose() {
    super.dispose();
    firstNameTxt.text.toString();
    emailTxt.text.toString();
    dateTxt.text.toString();
    genderTxt.text.toString();
  }

  void _showGenderBottomDialog() {
    String? gender = genderTxt.text.toString();
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SafeArea(
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Gender',
                            style: GoogleFonts.merriweather(
                                color: Color(0xFF13005A), fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Icon(
                                Icons.cancel,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      RadioListTile(
                        title: Text("Male"),
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                            genderTxt.text = value.toString();
                            Navigator.pop(context);
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Female"),
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                            genderTxt.text = value.toString();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
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
                  child: SingleChildScrollView(
                    // physics: BouncingScrollPhysics(
                    //     parent: AlwaysScrollableScrollPhysics()),
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
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, bottom: 10),
                            child: const Text(
                              'Basic Information',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                letterSpacing: 0.4,
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
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return 'Please enter first name';
                                } else if (!RegExp(r'^[a-z A-Z]+$')
                                    .hasMatch(value)) {
                                  return 'Please enter correct name';
                                } else {
                                  return null;
                                }
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
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return 'Please enter email';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter correct email';
                                } else {
                                  return null;
                                }
                              }),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: dateTxt,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.calendar_today),
                                labelText: "D.O.B",
                                hintText: "Choose D.O.B",
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
                                      DateFormat('dd-MM-yyyy')
                                          .format(pickedDate);
                                  print(formattedDate);

                                  setState(() {
                                    dateTxt.text = formattedDate;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please choose DOB';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: genderTxt,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.person_3_rounded),
                                suffixIcon:
                                    Icon(Icons.arrow_drop_down_outlined),
                                labelText: "Select Gender",
                                hintText: "Select Gender",
                              ),
                              onTap: () {
                                _showGenderBottomDialog();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select gender';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 335,
                              height: 45,
                              margin:
                                  const EdgeInsets.only(top: 40, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // _storeInDatabase();
                                    if (_formKey.currentState!.validate()) {
                                      _storeUserData();
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ProfileImageChooseScreen();
                                        },
                                      ));
                                    }
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
