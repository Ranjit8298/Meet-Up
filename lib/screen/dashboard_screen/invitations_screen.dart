import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_up/widgets/custom_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitationScreen extends StatefulWidget {
  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
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
          elevation: 0,
          backgroundColor: Color(0xFFE9E8E8),
          automaticallyImplyLeading: false,
          title: Container(
            child: Text(
              'Invitations',
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  color: Color(0xFF3D1766),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3),
            ),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.qr_code_scanner_rounded),
          //     onPressed: () {},
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.message_rounded),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.all(10),
          child: SafeArea(
              left: true,
              top: true,
              right: true,
              bottom: true,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    // margin: EdgeInsets.all(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 10,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0, // Soften the shaodw
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      '${userData[index]['location_image']}'),
                                ),
                              ),
                              Container(
                                width: 125,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10, right: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${userData[index]['location_name']}',
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Color(0xFF13005A),
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '${userData[index]['location_user_count']}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: FilledButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.blueGrey),
                                          ),
                                          onPressed: () {},
                                          child: Text('Reject')),
                                    ),
                                    FilledButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.green.shade700),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/MutualLikeScreen');
                                        },
                                        child: Text('Accept')),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ))
                ],
              )),
        ),
      ),
    );
  }

  var userData = [
    {
      'location_id': '1',
      'location_name': 'Social Hangout',
      'location_user_count': 'Today',
      'location_image':
          'https://www.euttaranchal.com/hotels/photos/lemon-tree-hotel-dehradun-1779387.jpg'
    },
    {
      'location_id': '2',
      'location_name': 'Chef Restaurant',
      'location_user_count': 'Today',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '3',
      'location_name': 'Kingford Hotel',
      'location_user_count': 'Today',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '4',
      'location_name': 'Taj Hotel',
      'location_user_count': 'Tomorrow',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '5',
      'location_name': 'Namsate Bharat',
      'location_user_count': 'Tomorrow',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '6',
      'location_name': 'Greenfield Hotel',
      'location_user_count': 'Tomorrow',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
    {
      'location_id': '7',
      'location_name': 'Doon Bar',
      'location_user_count': 'Tomorrow',
      'location_image':
          'https://media-cdn.tripadvisor.com/media/photo-s/22/25/ce/ea/kingsford-hotel-manila.jpg'
    },
    {
      'location_id': '8',
      'location_name': 'Poppins Hangout',
      'location_user_count': '26 Jan, 2023',
      'location_image':
          'https://thumbs.dreamstime.com/b/hotel-lobby-luxury-staircases-fountain-39479289.jpg'
    },
    {
      'location_id': '9',
      'location_name': 'Chai Sutta Bar',
      'location_user_count': '26 Jan, 2023',
      'location_image':
          'https://media.gettyimages.com/id/1333257932/photo/digitally-generated-image-of-the-luxurious-hotel-lobby.jpg?s=612x612&w=gi&k=20&c=7VWO0GX3BhfpPJW9BNnaMWEbCHZqfBNq--ccjw2Z8mk='
    },
    {
      'location_id': '10',
      'location_name': 'Roboto Hangout',
      'location_user_count': '15 Jan, 2023',
      'location_image':
          'https://media.istockphoto.com/id/119926339/photo/resort-swimming-pool.jpg?s=612x612&w=0&k=20&c=9QtwJC2boq3GFHaeDsKytF4-CavYKQuy1jBD2IRfYKc='
    },
  ];
}
