import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:clippy_flutter/clippy_flutter.dart';

class LocationScreen extends StatefulWidget {
  static const String id = "location_screen";

  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;
  late GoogleMapController mapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/markers.png");
  }

  void _onMapCreated(GoogleMapController controller) async {
    _customInfoWindowController.googleMapController = controller;

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = jsonDecode(data);

    for (int i = 0; i < jsonResult["locations"].length; i++) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("id-$i"),
            position: LatLng(
              double.parse(jsonResult["locations"][i]["latitude"]),
              double.parse(jsonResult["locations"][i]["longitude"]),
            ),
            icon: mapMarker,
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                _mapCustomInfoWindow(jsonResult, i),
                LatLng(
                  double.parse(jsonResult["locations"][i]["latitude"]),
                  double.parse(jsonResult["locations"][i]["longitude"]),
                ),
              );
            },
          ),
        );
      });
    }
  }

  Column _mapCustomInfoWindow(jsonResult, int i) => Column(
        children: [
          _customInfoWindowContainer(jsonResult, i),
          Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              color: kMainColor,
              width: 20.0,
              height: 10.0,
            ),
          ),
        ],
      );

  Container _customInfoWindowContainer(jsonResult, int i) => Container(
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jsonResult["locations"][i]["gymname"],
                style: kAppTitleTextStyle.copyWith(color: kWhiteColor),
              ),
              Text(
                jsonResult["locations"][i]["address"],
                style: const TextStyle(color: kWhiteColor),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(23.024548, 72.507365),
              zoom: 15,
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 350,
            offset: 30,
            height: 130,
          ),
        ],
      ),
    );
  }
}
