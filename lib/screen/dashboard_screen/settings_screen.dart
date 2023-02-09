import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_up/screen/onboarding_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String address = '';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  bool isSwitch = false;
  bool isSwitchB = true;
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

  logoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure want to logout?'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/LoginScreen');
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code_scanner_rounded),
              onPressed: () {},
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
                Colors.red.shade100,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: Image(
                              image: AssetImage('assets/images/user.png'))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Ranjit Kumar',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(top: 10),
                      child: FilledButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.edit_rounded),
                          label: Text('Edit Profile')),
                    ),
                    Container(
                      height: 135,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCFFE7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0, // Soften the shaodw
                            spreadRadius: 3.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "You're on our free plan",
                            style: TextStyle(
                                color: Color(0xFF00337C),
                                fontSize: 19,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Text(
                              "You want to make the most out of Hooked?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF00337C),
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width / 2,
                            child: FilledButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
                                onPressed: () {},
                                child: Text('Upgrade to PRO')),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 140,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2E5E5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0, // Soften the shaodw
                            spreadRadius: 3.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'GENERAL',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 15),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  'My Current Location',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.3),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  'Dehradun',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      letterSpacing: 0.3),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    'Search Radius',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    '50km',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        letterSpacing: 0.3),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    'Gender Preference',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    'male',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        letterSpacing: 0.3),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F5EB),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0, // Soften the shaodw
                            spreadRadius: 3.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'PRIVACY',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 15),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  'Push Notifications',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.3),
                                ),
                              ),
                              Container(
                                // width: 150,
                                child: Switch(
                                  value: isSwitchB,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSwitchB = value!;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    'Incognito Browsing',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3),
                                  ),
                                ),
                                Container(
                                    child: Switch(
                                  value: isSwitch,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSwitch = value!;
                                    });
                                  },
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 10),
                      width: 335,
                      height: 45,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            logoutDialog();
                          },
                          icon: Icon(Icons.logout_rounded),
                          label: Text(
                            'LOGOUT',
                            style: TextStyle(fontSize: 17),
                          )),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
