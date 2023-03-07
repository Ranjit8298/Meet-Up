import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_up/screen/onboarding_screen/access_location_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageChooseScreen extends StatefulWidget {
  @override
  State<ProfileImageChooseScreen> createState() =>
      _ProfileImageChooseScreenState();
}

class _ProfileImageChooseScreenState extends State<ProfileImageChooseScreen> {
  String imagepath = "";
  bool showLoder = true;

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemporary = image.path;
      setState(() {
        this.imagepath = imageTemporary;
        _storeUserData();

        Timer(const Duration(seconds: 3), (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AccessLocationScreen(mode:'signup');
          }));
        }));
      });
    }
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemporary = image.path;
      setState(() {
        this.imagepath = imageTemporary;
        _storeUserData();

        Timer(const Duration(seconds: 3), (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AccessLocationScreen(mode:'signup');
          }));
        }));
      });
    }
  }

  _storeUserData() async {
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    print(base64string);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userImg', base64string);
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 8, top: 5),
                            child: Text(
                              'SKIP',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 335,
                            height: 150,
                            margin: const EdgeInsets.only(top: 120),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 20.0, // Soften the shaodw
                                  spreadRadius: 3.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            child: Center(
                                child: Container(
                                    width: 120,
                                    height: 120,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red.shade50,
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 10.0, // Soften the shaodw
                                          spreadRadius: 3.0,
                                          offset: Offset(0.0, 0.0),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                    ),
                                    child: imagepath != ""
                                        ? new CircleAvatar(
                                            backgroundImage:
                                                new FileImage(File(imagepath)),
                                            radius: 65.0,
                                          )
                                        : Image(
                                            image: AssetImage(
                                                'assets/images/user.png'),
                                            fit: BoxFit.cover,
                                          ))),
                          ),
                        ),
                        Center(
                          child: Container(
                              width: 335,
                              height: 270,
                              margin: const EdgeInsets.only(top: 8, bottom: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 20.0, // Soften the shaodw
                                    spreadRadius: 3.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                              ),
                              child: Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Take a Selfie',
                                    style: GoogleFonts.merriweather(
                                      color: Color(0xFF3D1766),
                                      letterSpacing: 0.3,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Show us how you look and get more chances to meet people!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.merriweather(
                                      color: Color(0xFF3D1766),
                                      letterSpacing: 0.3,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 45,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          getImageFromCamera();
                                        },
                                        child: const Text(
                                          'TAKE PHOTO',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.4,
                                              fontSize: 16),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'OR',
                                      style: GoogleFonts.merriweather(
                                        color: Color(0xFF3D1766),
                                        letterSpacing: 0.3,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 260,
                                    height: 45,
                                    margin: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          getImageFromGallery();
                                        },
                                        child: const Text(
                                          'ACCESS GALLERY',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0.4,
                                              fontSize: 16),
                                        )),
                                  ),
                                ],
                              ))),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
