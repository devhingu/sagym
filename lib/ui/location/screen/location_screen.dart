import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constants.dart';
import '../../../constants/param_constants.dart';
import '../../../provider/location_provider.dart';
import '../../../utils/models/location_model.dart';

class LocationScreen extends StatefulWidget {
  static const String id = "location_screen";

  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  late BitmapDescriptor mapMarker;

  final Set<Marker> _markers = <Marker>{};
  final double _infoWindowWidth = 250;
  final double _markerOffset = 180;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), kMarkerImagePath);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    String data = await DefaultAssetBundle.of(context).loadString(kJsonPath);
    final jsonResult = jsonDecode(data);

    final providerObject =
        Provider.of<InfoWindowModelData>(context, listen: false);

    for (int i = 0; i < jsonResult[paramLocations].length; i++) {
      final location = jsonResult[paramLocations][i];

      double latitude = double.parse(location[paramLatitude]);
      double longitude = double.parse(location[paramLongitude]);
      String gymName = location[paramGymName];
      String address = location[paramAddress];
      LatLng latLng = LatLng(latitude, longitude);

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("marker-$i"),
            position: latLng,
            icon: mapMarker,
            onTap: () {
              providerObject.updateInfoWindow(
                context,
                mapController,
                latLng,
                _infoWindowWidth,
                _markerOffset,
              );
              providerObject.updateLocation(
                Location(
                  title: gymName,
                  address: address,
                  location: latLng,
                ),
              );
              providerObject.updateVisibility(true);
              providerObject.rebuildInfoWindow();
            },
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<InfoWindowModelData>(context, listen: false)
          .updateVisibility(false);
      Provider.of<InfoWindowModelData>(context, listen: false)
          .rebuildInfoWindow();
    });
    setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InfoWindowModelData>(
        builder: (context, model, child) {
          return Stack(
            children: <Widget>[
              child!,
              Positioned(
                left: 0,
                top: 0,
                child: Visibility(
                  visible: model.showInfoWindow,
                  child: (!model.showInfoWindow)
                      ? Container()
                      : _customInfoWindowContainer(model),
                ),
              ),
            ],
          );
        },
        child: Consumer<InfoWindowModelData>(
          builder: (context, model, child) {
            return Positioned(
              child: GoogleMap(
                onTap: (position) {
                  if (model.showInfoWindow) {
                    model.updateVisibility(false);
                    model.rebuildInfoWindow();
                  }
                },
                onCameraMove: (position) {
                  model.updateInfoWindow(
                    context,
                    mapController,
                    model.location.location,
                    _infoWindowWidth,
                    _markerOffset,
                  );
                  model.rebuildInfoWindow();
                },
                onMapCreated: _onMapCreated,
                markers: _markers,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(23.024548, 72.507365),
                  zoom: 15,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _customInfoWindowContainer(InfoWindowModelData model) => Container(
        margin: EdgeInsets.only(
          left: model.leftMargin,
          top: model.topMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: kMainColor,
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.4),
              offset: const Offset(0.0, 4.0),
              blurRadius: 20.0,
            ),
          ],
        ),
        height: 205,
        width: 300,
        padding: kAllSidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                model.location.title,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                model.location.address,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 50.0,
                  color: kWhiteColor,
                ),
              ),
            ),
          ],
        ),
      );
}
