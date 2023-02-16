import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final String headerTxt;
  final bool isMessageIcon;

  const CustomHeader({
    required this.headerTxt,
    required this.isMessageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      color: Color(0xFFE9E8E8),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isMessageIcon == true ? 260 : 310,
            child: Tooltip(
              showDuration: Duration(seconds: 2),
              message: headerTxt,
              preferBelow: true,
              excludeFromSemantics: true,
              enableFeedback: true,
              triggerMode: TooltipTriggerMode.tap,
              child: Text(
                headerTxt,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    color: Color(0xFF3D1766),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/QrScannerScreen');
              },
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.black,
              )),
          isMessageIcon == true
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MessageScreen');
                  },
                  icon: Icon(
                    Icons.message_rounded,
                    color: Colors.black,
                  ))
              : SizedBox(),
        ],
      ),
    );
  }
}
