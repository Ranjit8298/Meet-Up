import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meet_up/widgets/custom_textFormField.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  var firstNameTxt = TextEditingController(text: 'Ranjit');
  var emailTxt = TextEditingController(text: 'test.egineer@gmail.com');
  var dateTxt = TextEditingController();

  bool showLoder = true;

  @override
  void initState() {
    super.initState();
    dateTxt.text = "01-01-1999";
  }

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this._image = imageTemporary;
      });
    }
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this._image = imageTemporary;
      });
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) => SafeArea(
        child: Container(
          height: 175,
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Image',
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
              Row(
                children: [
                  Icon(
                    Icons.image,
                    color: Color(0xFF13005A),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // _handleImageSelection();
                      getImageFromGallery();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Choose from Gallary',
                          style: TextStyle(
                              color: Color(0xFF13005A),
                              fontSize: 16,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ],
              ),
              //take camera
              Row(
                children: [
                  Icon(
                    Icons.photo_camera,
                    color: Color(0xFF13005A),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // _handleTakeImageSelection();
                      getImageFromCamera();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Take Photo',
                          style: TextStyle(
                              color: Color(0xFF13005A),
                              fontSize: 16,
                              letterSpacing: 0.3)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFE9E8E8)));
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showLoder = false;
      });
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFE9E8E8),
            // automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Container(
              child: Text(
                'Edit Profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    color: Color(0xFF3D1766),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3),
              ),
            )),
        body: showLoder == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Center(
                        //   child: Container(
                        //     width: 240,
                        //     height: 240,
                        //     margin: const EdgeInsets.only(top: 10),
                        //     child: Image.asset('assets/images/edit_profile.png'),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Stack(children: [
                            Container(
                                child: _image != null
                                    ? new CircleAvatar(
                                        backgroundImage: new FileImage(_image!),
                                        radius: 65,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                            'assets/images/user.png'),
                                        radius: 60,
                                      )),
                            Positioned(
                              right: 8,
                              bottom: 5,
                              child: InkWell(
                                onTap: () {
                                  _handleAttachmentPressed();
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.image_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
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
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
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
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 160,
                                  child: FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.blueGrey),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('CANCEL')),
                                ),
                                Container(
                                  width: 160,
                                  child: FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {}
                                      },
                                      child: Text('SAVE')),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
