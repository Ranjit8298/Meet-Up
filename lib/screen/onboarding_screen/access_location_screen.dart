import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meet_up/screen/onboarding_screen/map_view_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';

class AccessLocationScreen extends StatefulWidget {
  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  String? _currentAddress;

  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
          const SnackBar(
              content: Text(
                  'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(
          const SnackBar(
              content: Text(
                  'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white24,
          Colors.blue.shade50,
          Colors.red.shade300
        ], begin: FractionalOffset(1.0, 0.0), end: FractionalOffset(0.0, 1.0))),
        padding: const EdgeInsets.all(10),
        child: SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    margin: const EdgeInsets.only(top: 100),
                    child: Image.asset(
                      'assets/images/access_location.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Access Live Location',
                      style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 0.3,
                          fontFamily: 'Poppins',
                          color: Colors.blue.shade900),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Search hangout places near by to locate your matches.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.3,
                          fontFamily: 'Poppins',
                          color: Colors.blue.shade900),
                    ),
                  ),
                  Container(
                    width: 335,
                    height: 45,
                    margin: const EdgeInsets.only(top: 60, bottom: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          _getCurrentPosition();

                          if (_currentPosition?.latitude != null &&
                              _currentPosition?.longitude != null) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MapViewScreen(
                                    latitude: _currentPosition?.latitude,
                                    longitude: _currentPosition?.longitude,
                                    currentAddress: _currentAddress);
                              },
                            ));
                          } else {
                            Center(
                                child: CircularProgressIndicator(
                              color: Colors.red,
                            ));
                          }

                          // var prefs = await SharedPreferences.getInstance();
                          // prefs.setString(
                          //     'latitude', _currentPosition?.latitude as String);
                          // prefs.setString('longitude',
                          //     _currentPosition?.longitude as String);
                          // prefs.setString('currentAddress', _currentAddress!);
                        },
                        child: const Text(
                          'ACCESS LOCATION',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.4,
                              fontSize: 16),
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
