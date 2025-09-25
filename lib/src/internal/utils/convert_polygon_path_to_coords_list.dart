part of '../../internal_use_library.dart';

List<LatLng> _convertPathToLatLngList(MVCArray path) {
  final points = <LatLng>[];
  final len = path.getLength();

  for (var i = 0; i < len; i++) {
    final jsLatLng = path.getAt(i);

    final lat = js_util.callMethod(jsLatLng, 'lat', []) as double;
    final lng = js_util.callMethod(jsLatLng, 'lng', []) as double;

    points.add(LatLng(lat, lng));
  }

  return points;
}