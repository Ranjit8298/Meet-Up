import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_drawing/path_drawing.dart';
import '../../widgets/curve_painter.dart';

class BrowseScreen extends StatefulWidget {
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late String address = '';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  CarouselController buttonCarouselController = CarouselController();

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
    return doSomeAsyncStuff().then((address) {
      setState(() => address = address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            child: Text(
              '${address}',
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
          color: Colors.black,
          padding: EdgeInsets.all(10),
          child: SafeArea(
              left: true,
              top: true,
              right: true,
              bottom: true,
              child: Center(
                child: CarouselSlider.builder(
                  itemCount: userData.length,
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enlargeFactor: 0.3,
                    autoPlay: false,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    // autoPlayCurve: Curves.linear
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      // padding: EdgeInsets.all(10),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 308,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.red.shade200,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        image: NetworkImage(
                                            '${userData[index]['location_image']}'))),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '${userData[index]['location_name']}',
                              style: TextStyle(
                                  color: Color(0xFF13005A),
                                  fontSize: 20,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: CustomPaint(
                                  painter: CurvePainter(),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    buttonCarouselController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 50, right: 50, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    buttonCarouselController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    // margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF13005A),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    buttonCarouselController.nextPage(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    // margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Icon(
                                      Icons.cancel_rounded,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )),
        ),
      ),
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
