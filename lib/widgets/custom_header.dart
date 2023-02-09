import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final String headerTxt;
  final Function onQrTap;
  final Function onMessageTap;

  const CustomHeader(
      {super.key,
      required this.headerTxt,
      required this.onQrTap,
      required this.onMessageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: Colors.red,
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 260,
              child: Text(
                headerTxt,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: InkWell(
                  onTap: onQrTap(context),
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                  )),
            ),
            Container(
              child: InkWell(
                  onTap: onMessageTap(),
                  child: Icon(
                    Icons.message_rounded,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
