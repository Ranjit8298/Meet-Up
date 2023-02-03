import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool isSwitchB = false;
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            'GENERAL',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                    ),
                    Container(
                      height: 110,
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2E5E5),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            'PRIVACY',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                    ),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F5EB),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0, // Soften the shaodw
                            spreadRadius: 3.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                      margin: EdgeInsets.only(top: 50),
                      width: 335,
                      height: 45,
                      child: ElevatedButton.icon(
                          onPressed: () {},
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
