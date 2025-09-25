import 'lat_lng.dart';

class PolygonData {
  final String id;
  final List<LatLng> points;
  final String fillColor;
  final double fillOpacity;

  PolygonData({
    required this.id,
    required this.points,
    this.fillColor = '#FF0000',
    this.fillOpacity = 0.4,
  });
}