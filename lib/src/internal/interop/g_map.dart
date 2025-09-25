part of '../../internal_use_library.dart';

@JS('google.maps.Map')
@staticInterop
class GMap {
  external factory GMap(JSAny mapDiv, JSAny options);
}

extension GMapExtension on GMap {
  external void panTo(LatLng latLng);
}

@JS()
@anonymous
@staticInterop
class MapOptions {
  external factory MapOptions({
    required LatLng center,
    required int zoom,
    String? mapId,
  });
}
