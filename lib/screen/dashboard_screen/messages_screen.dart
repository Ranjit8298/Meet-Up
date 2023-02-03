import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
        body: Center(
          child: Text('Message Screen'),
        ),
      ),
    );
  }
}
