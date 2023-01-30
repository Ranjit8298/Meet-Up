import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImageChooseScreen extends StatefulWidget {
  @override
  State<ProfileImageChooseScreen> createState() =>
      _ProfileImageChooseScreenState();
}

class _ProfileImageChooseScreenState extends State<ProfileImageChooseScreen> {
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
                              width: 110,
                              height: 110,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(55)),
                              ),
                              child: Image(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                  Center(
                    child: Container(
                        width: 335,
                        height: 270,
                        margin: const EdgeInsets.only(top: 8),
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
                                  color: Colors.purple.shade900,
                                  letterSpacing: 0.3,
                                  fontSize: 18,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Show us how you look and get more chances to meet people!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.purple.shade900,
                                letterSpacing: 0.3,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              width: 260,
                              height: 45,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return ProfileImageChooseScreen();
                                    //   },
                                    // ));
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
                                    color: Colors.purple.shade900,
                                    letterSpacing: 0.3,
                                    fontSize: 16,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Container(
                              width: 260,
                              height: 45,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              child: ElevatedButton(
                                  onPressed: () {},
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
