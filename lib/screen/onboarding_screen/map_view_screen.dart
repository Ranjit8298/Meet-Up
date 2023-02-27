import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meet_up/screen/dashboard_screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class MapViewScreen extends StatefulWidget {
  final double? latitude, longitude;
  late final String? currentAddress;
  String? mode;
  MapViewScreen(
      {required this.latitude,
      required this.longitude,
      required this.currentAddress,
      this.mode});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Set<Marker> markers = new Set();
  var uuid = Uuid();
  var snackBar = SnackBar(
      content:
          Text('congratulations, Your account has been created successfully.'));
  var snackBarError = SnackBar(content: Text("Failed to add user"));

  late String mobileNo;
  late String firstName;
  late String emailAddress;
  late String dob;
  late String gender;
  late String userImg;

  // static LatLng _center = LatLng(latitude!, longitude!);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> getmarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(widget.currentAddress.toString()),
        position: LatLng(widget.latitude!, widget.longitude!),
        infoWindow: InfoWindow(
          title: 'Your Current Address',
          snippet: widget.currentAddress.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markers;
  }

  void _onCameraMove(CameraPosition position) {
    widget.currentAddress = position.target as String?;
  }

  bool showLoder = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNo = prefs.getString('mobileNo')!;
      firstName = prefs.getString('firstName')!;
      emailAddress = prefs.getString('emailAddress')!;
      dob = prefs.getString('dob')!;
      gender = prefs.getString('gender')!;
      userImg = prefs.getString('userImg')!;
    });
  }

  Future<void> addUser() {
    return users
        .add({
          'user_id': uuid.v4(),
          'user_mobileNo': mobileNo,
          'user_firstName': firstName,
          'user_email': emailAddress,
          'user_dob': dob,
          'user_gender': gender,
          'user_img': userImg,
          'user_location': widget.currentAddress,
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(snackBar))
        .catchError((error) =>
            ScaffoldMessenger.of(context).showSnackBar(snackBarError));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _getUserData();
        showLoder = false;
      });
    });
    return Scaffold(
        appBar: null,
        body: showLoder == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                left: true,
                top: true,
                right: true,
                bottom: true,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      indoorViewEnabled: true,
                      trafficEnabled: true,
                      markers: getmarkers(),
                      onCameraMove: _onCameraMove,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.latitude!, widget.longitude!),
                        zoom: 17.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: 200,
                              height: 45,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    widget.mode == 'signup' ? addUser() : null;

                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('address',
                                        widget.currentAddress.toString());
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return BottomTab();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    'NEXT',
                                    style: TextStyle(fontSize: 18),
                                  )))),
                    ),
                  ],
                ),
              ));
  }
}
