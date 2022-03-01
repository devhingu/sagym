import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;
  late GoogleMapController controller;
  // CustomInfoWindowController _customInfoWindowController =
  //     CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/markers.png");
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('id-1'),
          icon: mapMarker,
          position: const LatLng(22.979771, 72.492714),
          // onTap: () {
          //   _customInfoWindowController.addInfoWindow!(
          //     Column(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color:kMainColor,
          //               borderRadius: BorderRadius.circular(4),
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Image.asset(
          //                     kDumbbellImagePath,
          //                     height: 25.0,
          //                   ),
          //                   SizedBox(
          //                     width: 8.0,
          //                   ),
          //                   Text(
          //                     "Sarkhej",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .headline6
          //                         ?.copyWith(
          //                           color: Colors.white,
          //                         ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             width: double.infinity,
          //             height: double.infinity,
          //           ),
          //         ),
                  //
                  // Triangle.isosceles(
                  //   edge: Edge.BOTTOM,
                  //   child: Container(
                  //     color: kMainColor,
                  //     width: 20.0,
                  //     height: 10.0,
                  //   ),
                  // ),
          //       ],
          //     ),
          //     LatLng(22.979771, 72.492714),
          //   );
          // },
          infoWindow:
              const InfoWindow(title: "Sarkhej", snippet: "A Beautiful place"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: GoogleMap(
       onMapCreated: _onMapCreated,
       markers: _markers,
       initialCameraPosition: const CameraPosition(
         target: LatLng(22.979771, 72.492714),
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
