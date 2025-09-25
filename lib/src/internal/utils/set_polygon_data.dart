part of '../../internal_use_library.dart';

/// Set Polygon data if we are either in the zone list or editing zone screen
void _setPolygonData({
  required DrawingManager drawingManager,
  required bool Function() isPolygonCreated,
  required void Function(List<LatLng> points, Polygon overlay) onPolygonCreated,
}) {
  js_util.callMethod(drawingManager, 'addListener', ['overlaycomplete',
    js_util.allowInterop((event) {
      final overlay = js_util.getProperty(event, 'overlay') as Polygon;

      if (isPolygonCreated()) {
        overlay.setMap(null);
        html.window.alert('Only one polygon is allowed at a time.');
        return;
      }

      final path = overlay.getPath();
      final length = path.getLength();

      final points = <LatLng>[];
      for (var i = 0; i < length; i++) {
        final point = path.getAt(i);
        final lat = js_util.callMethod(point, 'lat', []) as num;
        final lng = js_util.callMethod(point, 'lng', []) as num;
        points.add(LatLng(lat, lng));

        /// The polygon's last LatLng must be equal to the first
        if (i == length - 1) points.add(points.first);
      }

      onPolygonCreated(points, overlay);
    }),
  ]);
}