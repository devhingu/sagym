import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;
  late GoogleMapController mapController;
  // CustomInfoWindowController _customInfoWindowController =
  //     CustomInfoWindowController();

  void getLocations() async {}

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    getLocations();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/markers.png");
  }

  void _onMapCreated(GoogleMapController controller) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = jsonDecode(data);

    for (int i = 0; i < jsonResult["locations"].length; i++) {
      setState(() {
        _markers.add(
          Marker(
            markerId:  MarkerId("id-$i"),
            position: LatLng(
              double.parse(jsonResult["locations"][i]["latitude"]),
              double.parse(jsonResult["locations"][i]["longitude"]),
            ),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: jsonResult["locations"][i]["gymname"],
              snippet: jsonResult["locations"][i]["address"],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.024548, 72.507365),
          zoom: 15,
        ),
      ),
    );
  }
}

/* body: Stack(
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
              target: LatLng(22.979771, 72.492714),
              zoom: 15,
            ),

          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
          ),
        ],
      ),*/
