import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/models/location_model.dart';

class InfoWindowModelData extends ChangeNotifier {
  bool _showInfoWindow = false;
  bool _tempHidden = false;
  var _location;
  double _leftMargin = 0.0;
  double _topMargin = 0.0;

  void rebuildInfoWindow() {
    notifyListeners();
  }

  void updateLocation(Location location) {
    _location = location;
  }

  void updateVisibility(bool visibility) {
    _showInfoWindow = visibility;
  }

  void updateInfoWindow(BuildContext context, GoogleMapController controller,
      LatLng location, double infoWindowWidth, double markerOffset) async {
    ScreenCoordinate screenCoordinate =
        await controller.getScreenCoordinate(location);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio * 0.87) -
        (infoWindowWidth / 2);
    double top =
        (screenCoordinate.y.toDouble() / devicePixelRatio * 0.70) - markerOffset;
    if (left < 0 || top < 0) {
      _tempHidden = true;
    } else {
      _tempHidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }

  bool get showInfoWindow =>
      (_showInfoWindow == true && _tempHidden == false) ? true : false;

  double get leftMargin => _leftMargin;

  double get topMargin => _topMargin;

  Location get location => _location;
}
