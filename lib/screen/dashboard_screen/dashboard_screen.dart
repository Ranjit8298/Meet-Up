import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_up/screen/dashboard_screen/browse_screen.dart';
import 'package:meet_up/screen/dashboard_screen/invitations_screen.dart';
import 'package:meet_up/screen/dashboard_screen/matches_user_screen.dart';
import 'package:meet_up/screen/dashboard_screen/messages_screen.dart';
import 'package:meet_up/screen/dashboard_screen/qr_scanner_screen.dart';
import 'package:meet_up/screen/dashboard_screen/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomTab extends StatefulWidget {
  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    BrowseScreen(),
    InvitationScreen(),
    MessageScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded), label: 'Browse'),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_invitation_rounded),
                label: 'Invitation'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Message'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: 'Setting'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          elevation: 5,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var searchTxt = TextEditingController();
  late String address = '';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    var prefs = await SharedPreferences.getInstance();
    address = prefs.getString('address')!;
    print(address);
  }

  Future<Null> _refresh() {
    return doSomeAsyncStuff().then((_user) {
      setState(() => address = address);
    });
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

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                child: Tooltip(
                  showDuration: Duration(seconds: 2),
                  message: address,
                  preferBelow: true,
                  excludeFromSemantics: true,
                  enableFeedback: true,
                  triggerMode: TooltipTriggerMode.tap,
                  child: Text(
                    address,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3),
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.qr_code_scanner_rounded),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return QrScannerScreen();
                      },
                    ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.message_rounded),
                  onPressed: () {},
                ),
              ],
            ),
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
                      Container(
                        // margin: EdgeInsets.all(10),
                        color: Color(0xFFF7EFE5),
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: searchTxt,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Search by Location',
                            hintText: 'Search by Location',
                            isDense: true,
                            prefixIcon: Icon(Icons.search_rounded),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              // borderSide: const BorderSide(color: Colors.grey)
                            ),
                          ),
                        ),
                      ),
                      // seprator(),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 40,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MatchesUserScreen(
                                          locationName: userData[index]
                                              ['location_name'],
                                          userCount: userData[index]
                                              ['location_user_count']);
                                    },
                                  ));
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 170,
                                          height: 120,
                                          child: Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${userData[index]['location_image']}'))),
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        child: Text(
                                          '${userData[index]['location_name']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF3D1766),
                                              fontSize: 16,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 0),
                                        child: Text(
                                          '${userData[index]['location_user_count']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              letterSpacing: 0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: userData.length,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  var userData = [
    {
      'location_id': '1',
      'location_name': 'Social Hangout',
      'location_user_count': '15 User Live',
      'location_image':
          'https://www.euttaranchal.com/hotels/photos/lemon-tree-hotel-dehradun-1779387.jpg'
    },
    {
      'location_id': '2',
      'location_name': 'Chef Restaurant',
      'location_user_count': '10 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '3',
      'location_name': 'Kingford Hotel',
      'location_user_count': '18 User Live',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '4',
      'location_name': 'Taj Hotel',
      'location_user_count': '06 User Live',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '5',
      'location_name': 'Namsate Bharat',
      'location_user_count': '25 User Live',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '6',
      'location_name': 'Greenfield Hotel',
      'location_user_count': '35 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '7',
      'location_name': 'Doon Bar',
      'location_user_count': '05 User Live',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '8',
      'location_name': 'Poppins Hangout',
      'location_user_count': '16 User Live',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '9',
      'location_name': 'Chai Sutta Bar',
      'location_user_count': '10 User Live',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '10',
      'location_name': 'Roboto Hangout',
      'location_user_count': '15 User Live',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
  ];
}
