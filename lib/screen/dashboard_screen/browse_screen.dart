import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/curve_painter.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseScreen extends StatefulWidget {
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late String address = '';
  bool showLoder = true;

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

  _showSimpleModalDialog(context) {
    var distance = 2;
    double _startValue = 18.0;
    double _endValue = 100.0;
    bool male = false;
    bool female = false;
    bool everyone = false;

    void maleSelect() {
      if (male == false) {
        male = true;
        female = false;
        everyone = false;
      } else {
        male = false;
      }
    }

    void feMaleSelect() {
      if (female == false) {
        female = true;
        male = false;
        everyone = false;
      } else {
        female = false;
      }
    }

    void everyoneSelect() {
      if (everyone == false) {
        male = false;
        female = false;
        everyone = true;
      } else {
        everyone = false;
      }
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  // constraints: BoxConstraints(minHeight: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Browse Filters',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(0.5)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                'Select Distance',
                                style: TextStyle(
                                    color: Color(0xFF0A2647),
                                    fontSize: 16,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${distance} km',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Slider(
                          min: 2,
                          max: 100,
                          divisions: 100,
                          label: '${distance.round()}',
                          value: distance.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              distance = value.toInt();
                              print(distance);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              child: Text(
                                'Select Age',
                                style: TextStyle(
                                    color: Color(0xFF0A2647),
                                    fontSize: 16,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${_startValue.toInt()} - ${_endValue.toInt()}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        RangeSlider(
                          min: 18.0,
                          max: 100.0,
                          divisions: 100,
                          labels: RangeLabels(
                            _startValue.round().toString(),
                            _endValue.round().toString(),
                          ),
                          values: RangeValues(_startValue, _endValue),
                          onChanged: (values) {
                            setState(() {
                              _startValue = values.start;
                              _endValue = values.end;
                            });
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text(
                              'Select Gender',
                              style: TextStyle(
                                  color: Color(0xFF0A2647),
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    maleSelect();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: male == false
                                              ? Colors.grey
                                              : Colors.red)),
                                  child: Center(
                                      child: Text(
                                    'Male',
                                    style: TextStyle(
                                        color: male == false
                                            ? Colors.grey
                                            : Colors.red),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    feMaleSelect();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: female == false
                                              ? Colors.grey
                                              : Colors.red)),
                                  child: Center(
                                      child: Text(
                                    'Female',
                                    style: TextStyle(
                                        color: female == false
                                            ? Colors.grey
                                            : Colors.red),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    everyoneSelect();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: everyone == false
                                              ? Colors.grey
                                              : Colors.red)),
                                  child: Center(
                                      child: Text(
                                    'Everyone',
                                    style: TextStyle(
                                        color: everyone == false
                                            ? Colors.grey
                                            : Colors.red),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 290,
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('SUBMIT')),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLoder = false;
      });
    });
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFE9E8E8),
          elevation: 0,
          title: Container(
            child: Text(
              "Browse",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  color: Color(0xFF3D1766),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/FavoriteScreen');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.filter_alt_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                _showSimpleModalDialog(context);
              },
            ),
          ],
        ),
        body:showLoder == true ? Center(child: CircularProgressIndicator(),): Container(
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
                      padding: EdgeInsets.all(10),
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
                              Center(
                                child: Container(
                                  width: 300,
                                  height: 410,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3)),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 340,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xFFD3D3D3)),
                                      borderRadius: BorderRadius.circular(15)),
                                  // padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15)),
                                            child: Image(
                                                fit: BoxFit.cover,
                                                height: 290,
                                                image: NetworkImage(
                                                    '${userData[index]['location_image']}'))),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${userData[index]['location_name']}, ',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF13005A),
                                                          fontSize: 18,
                                                          letterSpacing: 0.3,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '21',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF13005A),
                                                          fontSize: 18,
                                                          letterSpacing: 0.3,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Lives in Dehradun',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  'UI UX Designer',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  '3 mutual friends',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.grey,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
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
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(top: 24),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 60, right: 60, bottom: 15),
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
                                    width: 50,
                                    height: 50,
                                    // margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF13005A),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 40,
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
                                    width: 50,
                                    height: 50,
                                    // margin: EdgeInsets.only(top: 32),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Icon(
                                      Icons.cancel_rounded,
                                      size: 40,
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
