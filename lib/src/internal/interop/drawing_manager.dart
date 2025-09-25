part of '../../internal_use_library.dart';

@JS('google.maps.drawing.DrawingManager')
@staticInterop
class DrawingManager {
  external factory DrawingManager(DrawingManagerOptions options);
}

extension DrawingManagerExtension on DrawingManager {
  external void setMap(GMap? map);
  external void setDrawingMode(String? mode);
}

@JS()
@anonymous
@staticInterop
class DrawingManagerOptions {
  external factory DrawingManagerOptions({
    JSAny? drawingMode,
    bool? drawingControl,
    JSAny? drawingControlOptions,
    JSAny? polygonOptions,
    JSAny? map,
  });
}
