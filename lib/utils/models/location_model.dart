import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final String title;
  final String address;
  final LatLng location;

  Location({
    required this.title,
    required this.address,
    required this.location,
  });
}