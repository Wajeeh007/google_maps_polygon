import 'dart:js_interop';

import '../src/internal_use_library.dart';

@JS('google.maps.LatLng')
@staticInterop
class LatLng {
  external factory LatLng(num lat, num lng);
}

extension LatLngExtension on LatLng {
  external num get lat;
  external num get lng;
}

@JS('google.maps.LatLngBounds')
@staticInterop
class LatLngBounds {
  external factory LatLngBounds();
}

extension LatLngBoundsExtension on LatLngBounds {
  external void extend(LatLng latLng);
}

extension GMapExtension on GMap {
  external void fitBounds(LatLngBounds bounds);
}