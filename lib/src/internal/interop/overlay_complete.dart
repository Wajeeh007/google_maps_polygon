part of '../../internal_use_library.dart';

@JS()
@staticInterop
class OverlayCompleteEvent {}

extension OverlayCompleteEventExtension on OverlayCompleteEvent {
  external Polygon get overlay;
}

void attachOverlayCompleteListener(DrawingManager drawingManager, GMap map) {
  addListener(
    drawingManager as JSAny,
    'overlaycomplete',
    js_util.allowInterop((OverlayCompleteEvent e) {
      final polygon = e.overlay;
      polygon.setMap(map);
    }).toJS,
  );
}