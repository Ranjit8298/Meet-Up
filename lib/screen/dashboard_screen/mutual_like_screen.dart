import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class MutualLikeScreen extends StatefulWidget {
  @override
  State<MutualLikeScreen> createState() => _MutualLikeScreenState();
}

class _MutualLikeScreenState extends State<MutualLikeScreen> {
  bool showLoder = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFE9E8E8)));
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLoder = false;
      });
    });
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Color(0xFFE9E8E8),
        title: Text(
          'Mutual Like',
          style: GoogleFonts.merriweather(
              color: Color(0xFF3D1766),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3),
        ),
      ),
      body: showLoder == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(top: 120),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RotationTransition(
                                  turns: new AlwaysStoppedAnimation(-15 / 360),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      child: Image(
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/4/48/Outdoors-man-portrait_%28cropped%29.jpg',
                                        ),
                                      )),
                                ),
                                Container(
                                    width: 55,
                                    height: 55,
                                    transform: Matrix4.translationValues(
                                        0.0, -36.0, 0.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(27.5),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5.0,
                                              spreadRadius: 5.0,
                                              offset: Offset(0.0, 0.0),
                                              color: Color(0xFFD3D3D3))
                                        ]),
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        child: Lottie.asset(
                                            'assets/row/heart.json'))),
                                RotationTransition(
                                  turns: new AlwaysStoppedAnimation(15 / 360),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    child: Image(
                                      image: NetworkImage(
                                        'https://assets.ajio.com/medias/sys_master/root/20221220/lRM3/63a0db4df997ddfdbde15777/besucher_peach_floral_pattern_silk_saree_.jpg',
                                      ),
                                      height: 200,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                "It's a match!",
                                style: GoogleFonts.merriweather(
                                    color: Color(0xFFD61355),
                                    fontSize: 26,
                                    letterSpacing: 0.3),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              // width: 310,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "You and Test Engineer like each other, you can now send him a message.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                    color: Color(0xFF3D1766),
                                    fontSize: 18,
                                    letterSpacing: 0.3),
                              ),
                            ),
                            Container(
                              width: 335,
                              height: 45,
                              margin: EdgeInsets.only(top: 50),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'MESSAGE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0.3,
                                        fontSize: 18),
                                  )),
                            ),
                            Container(
                              width: 335,
                              height: 45,
                              margin: EdgeInsets.only(top: 25),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF3D1766),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'KEEP BROWSING',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0.3,
                                        fontSize: 18),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
    );
  }
}
