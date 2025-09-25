part of '../../internal_use_library.dart';

void moveToPolygon(GMap map, PolygonData polygon) {
  final bounds = LatLngBounds();
  for (final point in polygon.points) {
    bounds.extend(point);
  }
  map.fitBounds(bounds);
}