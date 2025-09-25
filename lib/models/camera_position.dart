import 'lat_lng.dart';

class CameraPosition {

  LatLng initialCoords;
  int zoom;

  CameraPosition({
    required this.initialCoords,
    this.zoom = 12
  });

}