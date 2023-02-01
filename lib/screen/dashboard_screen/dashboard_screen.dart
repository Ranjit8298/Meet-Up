import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  final String? address;
  DashboardScreen({this.address});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var searchTxt = TextEditingController();

  var userData = [
    {
      'location_id': '1',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
    {
      'location_id': '2',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
    {
      'location_id': '3',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
    {
      'location_id': '4',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
    {
      'location_id': '5',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
    {
      'location_id': '6',
      'location_name': 'Social Hangout',
      'location_image': 'assets/images/resturant_2.jpg'
    },
  ];

  Container seprator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      // color: Colors.grey,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF3D1766),
        Color(0xFF6F1AB6),
        Color(0xFFFCFFE7),
        Color(0xFFFF0032),
        Color(0xFFCD0404),
      ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: null,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Colors.white,
                  Colors.white24,
                  Colors.blue.shade50,
                  Colors.red.shade100
                ],
                    begin: FractionalOffset(1.0, 0.0),
                    end: FractionalOffset(0.0, 1.0))),
            // padding: const EdgeInsets.all(10),
            child: SafeArea(
                left: true,
                top: true,
                right: true,
                bottom: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Container(
                            width: 225,
                            child: Text(
                              widget.address!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF3D1766),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Icon(
                                Icons.message_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    seprator(),
                    Container(
                      margin: EdgeInsets.all(10),
                      // padding: EdgeInsets.all(10),
                      // height: 48,
                      child: TextField(
                        controller: searchTxt,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Search by Location',
                            hintText: 'Search by Location',
                            prefixIcon: Icon(Icons.search_rounded)),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
