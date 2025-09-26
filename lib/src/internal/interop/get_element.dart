part of '../../internal_use_library.dart';

@JS('document.getElementById')
external JSObject? _getElementById(String id);

extension HTMLElementExtension on JSObject {
  external void remove();
}

void removeMapDiv(String id) {
  final el = _getElementById(id);
  el?.remove();
}
