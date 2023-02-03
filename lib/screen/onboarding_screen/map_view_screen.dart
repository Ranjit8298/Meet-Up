import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meet_up/screen/dashboard_screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapViewScreen extends StatefulWidget {
  final double? latitude, longitude;
  late final String? currentAddress;
  MapViewScreen(
      {required this.latitude,
      required this.longitude,
      required this.currentAddress});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
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
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () async {
                              var prefs = await SharedPreferences.getInstance();
                              prefs.setString(
                                  'address', widget.currentAddress.toString());
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return BottomTab();
                                },
                              ));
                            },
                            child: Text('NEXT')))),
              ),
            ],
          ),
        ));
  }
}
