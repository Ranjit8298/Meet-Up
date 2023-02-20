import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_up/model/dashboard_user_model.dart';
import 'package:meet_up/screen/dashboard_screen/browse_screen.dart';
import 'package:meet_up/screen/dashboard_screen/invitations_screen.dart';
import 'package:meet_up/screen/dashboard_screen/matches_user_screen.dart';
import 'package:meet_up/screen/dashboard_screen/messages_screen.dart';
import 'package:meet_up/screen/dashboard_screen/settings_screen.dart';
import 'package:meet_up/widgets/custom_header.dart';
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_rounded), label: 'Browse'),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_invitation_rounded),
                label: 'Invitations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Message'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: 'Settings'),
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
  TextEditingController searchTxt = TextEditingController();

  late String address = '';
  bool showLoder = true;
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

  static List<DashboardUserModel> main_dashboardUserList = [
    DashboardUserModel('Social Hangout', '15 User Live',
        'https://www.euttaranchal.com/hotels/photos/lemon-tree-hotel-dehradun-1779387.jpg'),
    DashboardUserModel('Chef Restaurant', '10 User Live',
        'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='),
    DashboardUserModel('Kingford Hotel', '18 User Live',
        'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'),
    DashboardUserModel('Taj Hotel', '06 User Live',
        'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'),
    DashboardUserModel('Namsate Bharat', '25 User Live',
        'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='),
    DashboardUserModel('Greenfield Hotel', '35 User Live',
        'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='),
    DashboardUserModel('Doon Bar', '05 User Live',
        'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'),
    DashboardUserModel('Poppins Hangout', '16 User Live',
        'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'),
    DashboardUserModel('Chai Sutta Bar', '10 User Live',
        'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='),
    DashboardUserModel('Roboto Hangout', '15 User Live',
        'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='),
  ];

  List<DashboardUserModel> display_dashboardUserList =
      List.from(main_dashboardUserList);

  void updateList(String value) {
    setState(() {
      display_dashboardUserList = main_dashboardUserList
          .where((element) => element.location_name!
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFE9E8E8),
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLoder = false;
        address = address;
      });
    });
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
            body: showLoder == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: SafeArea(
                        left: true,
                        top: true,
                        right: true,
                        bottom: true,
                        child: Column(
                          children: [
                            Container(
                              child: CustomHeader(
                                headerTxt: address,
                                isMessageIcon: true,
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.all(10),
                              // color: Color(0xFFF7EFE5),
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: searchTxt,
                                maxLines: 1,
                                onChanged: (value) {
                                  updateList(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search by Place Name',
                                  hintText: 'Search by Place Name',
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
                              child: display_dashboardUserList.length == 0
                                  ? Center(
                                      child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image(
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                                image: new AssetImage(
                                                    'assets/images/no_result.png')),
                                          ),
                                          Container(
                                            child: Text(
                                              'No Result Found',
                                              style: GoogleFonts.merriweather(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.3,
                                                  color: Color(0xFF3D1766)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                  : Container(
                                      margin: EdgeInsets.all(10),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            display_dashboardUserList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 40,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return MatchesUserScreen(
                                                      locationName:
                                                          display_dashboardUserList[
                                                                  index]
                                                              .location_name,
                                                      userCount:
                                                          display_dashboardUserList[
                                                                  index]
                                                              .location_user_count);
                                                },
                                              ));
                                            },
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 170,
                                                      height: 120,
                                                      child: Image(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              '${display_dashboardUserList[index].location_image}'))),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 3),
                                                    child: Text(
                                                      '${display_dashboardUserList[index].location_name}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF3D1766),
                                                          fontSize: 16,
                                                          letterSpacing: 0.3),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 0),
                                                    child: Text(
                                                      '${display_dashboardUserList[index].location_user_count}',
                                                      textAlign:
                                                          TextAlign.center,
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
                                      ),
                                    ),
                            )
                          ],
                        )),
                  ),
          )),
    );
  }
}
