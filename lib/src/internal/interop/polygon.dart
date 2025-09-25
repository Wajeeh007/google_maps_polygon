part of '../../internal_use_library.dart';

@JS('google.maps.Polygon')
@staticInterop
class Polygon {
  external factory Polygon(PolygonOptions options);
}

@JS('google.maps.MVCArray')
@staticInterop
class MVCArray<T extends JSAny> {
  external factory MVCArray();
}

@JS('google.maps.event.addListener')
external void addListener(JSAny instance, String eventName, JSFunction handler);

extension MVCArrayExtension<T extends JSAny> on MVCArray<T> {
  external int getLength();
  external T getAt(int i);
  external void forEach(JSFunction callback);
}

extension PolygonExtension on Polygon {
  external MVCArray getPath();
  external void setMap(GMap? map);
  external void setEditable(bool editable);
  external void setOptions(PolygonOptions opts);
}

extension PolygonEditingExtension on Polygon {
  void enableEditing(void Function(List<LatLng>) onChanged) {
    setEditable(true);

    final path = getPath();

    /// Attach event listeners
    void fireChange() {
      final points = _convertPathToLatLngList(path);
      onChanged(points);
    }

    addListener(path as JSAny, 'insert_at', ((JSAny index) {
      fireChange();
    }).toJS);

    addListener(path as JSAny, 'remove_at', ((JSAny index) {
      fireChange();
    }).toJS);

    addListener(path as JSAny, 'set_at', ((JSAny index, JSAny previous) {
      fireChange();
    }).toJS);

  }
}


/// Polygon options
@JS()
@anonymous
@staticInterop
class PolygonOptions {
  external factory PolygonOptions({
    JSAny? map,
    JSAny? paths,
    bool? editable,
  });
}