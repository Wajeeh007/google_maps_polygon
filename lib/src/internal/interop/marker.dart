import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:js_util' as js_util;
import '../../../models/lat_lng.dart';

@JS('google.maps.marker.AdvancedMarkerElement')
@staticInterop
class AdvancedMarkerElement {
  external factory AdvancedMarkerElement(AdvancedMarkerOptions options);
}

extension AdvancedMarkerElementExtension on AdvancedMarkerElement {
  external void setMap(JSAny? map);
  external void setPosition(LatLng position);
  external LatLng? getPosition();
}

@JS()
@anonymous
@staticInterop
class AdvancedMarkerOptions {
  external factory AdvancedMarkerOptions({
    LatLng? position,
    JSAny? map,
    JSAny? content,
    String? title,
    JSAny? icon,
  });
}

extension AdvancedMarkerOptionsExtension on AdvancedMarkerOptions {
  external LatLng? get position;
  external JSAny? get map;
  external JSAny? get content;
  external String? get title;
  external JSAny? get icon;
}

/// Helper for icon
JSAny iconOptions(String url) {
  return jsObject<JSAny>({
    'url': url,
    'scaledSize': jsObject<JSAny>({
      'width': 40,
      'height': 40,
    }),
  });
}

/// Small helper to convert Dart map -> JS object literal
T jsObject<T extends JSAny>(Map<String, Object?> dartMap) {
  final jsObj = JSObject();
  for (final entry in dartMap.entries) {
    jsObj.setProperty(entry.key.toJS, entry.value.jsify());
  }
  return jsObj as T;
}

/// Small helpers to create JS objects inline (for options)

@JS('Object')
external JSObject _jsObject();

/// A very small jsify helper (wraps Dart Map into a JS object)
@JS('Object.assign')
external JSObject _jsAssign(JSObject target, JSObject source);

JSObject jsify(Map<String, Object?> data) {
  final obj = _jsObject();
  data.forEach((k, v) {
    // convert values to JSAny via `js_util.jsify` or manual wrapping
    final jsValue = js_util.jsify(v) as JSAny;
    _jsAssign(obj, _jsObjectWith(k, jsValue));
  });
  return obj;
}

@JS('Object')
JSObject _jsObjectWith(String key, JSAny? value) {
  final obj = _jsObject();
  js_util.setProperty(obj, key, value);
  return obj;
}