import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_up/screen/onboarding_screen/access_location_screen.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';

class ProfileImageChooseScreen extends StatefulWidget {
  @override
  State<ProfileImageChooseScreen> createState() =>
      _ProfileImageChooseScreenState();
}

class _ProfileImageChooseScreenState extends State<ProfileImageChooseScreen> {
  File? _image;
  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this._image = imageTemporary;

        Timer(const Duration(seconds: 3), (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AccessLocationScreen();
          }));
        }));
      });
    }
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemporary = File(image.path);
      setState(() {
        this._image = imageTemporary;

        Timer(const Duration(seconds: 3), (() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AccessLocationScreen();
          }));
        }));
      });
    }
  }

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
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.purple.shade50,
                              Colors.blue.shade50,
                              Colors.red.shade50
                            ],
                            begin: FractionalOffset(1.0, 0.0),
                            end: FractionalOffset(0.0, 1.0)),
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
                              child: _image != null
                                  ? new CircleAvatar(
                                      backgroundImage: new FileImage(_image!),
                                      radius: 55,
                                    )
                                  : Image(
                                      image:
                                          AssetImage('assets/images/user.png'),
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
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  letterSpacing: 0.3,
                                  fontSize: 20,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Show us how you look and get more chances to meet people!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  letterSpacing: 0.3,
                                  fontSize: 16,
                                  fontFamily: 'Itim'),
                            ),
                            Container(
                              width: 260,
                              height: 45,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 10),
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
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    letterSpacing: 0.3,
                                    fontSize: 16,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Container(
                              width: 260,
                              height: 45,
                              margin:
                                  const EdgeInsets.only(top: 20,),
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
