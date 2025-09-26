library;

import 'dart:async';
import '../../models/lat_lng.dart';
import '../internal_use_library.dart';

part 'bindings/bind_functions_to_controller.dart';

/// Public controller shown to users of the package/app.
class GoogleMapPolygonController {
  final _GoogleMapPolygonControllerInternal _internal = _GoogleMapPolygonControllerInternal();

  /// Move the map camera (public)
  void moveTo(double lat, double lng) {
    _internal.moveTo(lat, lng);
  }

  /// Listen for polygon created events (public stream)
  Stream<Map<String, dynamic>> get onPolygonCreated =>
      _internal.onPolygonCreated;

  /// Clear polygon from the map (public)
  void clearPolygon() {
    _internal.clearPolygon();
  }

  /// Dispose controller resources
  void dispose() {
    _internal.dispose();
  }
}

/// Private/internal object — visible inside this library (parts).
class _GoogleMapPolygonControllerInternal {
  GMap? _gMap;

  // void Function(Map<String, dynamic> zoneData)? _addToPolygonRefs;
  // void Function(Map<String, dynamic> zoneData)? _updateZonePolygon;
  // void Function(bool value)? _updatePolygonCreated;
  void Function()? _clearPolygon;

  final _polygonCreatedController = StreamController<Map<String, dynamic>>.broadcast();

  /// Internal: move camera
  void moveTo(double lat, double lng) {
    _gMap?.panTo(LatLng(lat, lng));
  }

  /// Internal: clear polygon
  void clearPolygon() {
    if (_clearPolygon != null) {
      _clearPolygon!();
    }
  }

  /// Internal: expose stream
  Stream<Map<String, dynamic>> get onPolygonCreated =>
      _polygonCreatedController.stream;

  /// Internal: cleanup
  void dispose() {
    _polygonCreatedController.close();
  }
}
