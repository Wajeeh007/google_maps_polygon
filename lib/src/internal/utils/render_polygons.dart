import 'dart:js_util' as js_util;
import 'dart:js_interop';

import '../../internal_use_library.dart';

void renderPolygons({
  required List<PolygonData> polygons,
  required Map<String, Polygon> polygonRefs,
  required GMap gMap,
  bool editPolygon = false,
  void Function(dynamic value)? onPolygonCreated,
}) {

  final newIds = polygons.map((p) => p.id).toSet();

  final toRemove = polygonRefs.keys.where((id) => !newIds.contains(id)).toList();
  for (final id in toRemove) {
    polygonRefs[id]?.setMap(null);
    polygonRefs.remove(id);
  }

  for (var polygon in polygons) {
    if (!polygonRefs.containsKey(polygon.id)) {

      final jsPaths = polygon.points.toList();

      final jsPolygon = Polygon(PolygonOptions(
        map: gMap as JSAny,
        paths: js_util.jsify(jsPaths) as JSAny,
        editable: editPolygon,
      ));

      polygonRefs[polygon.id] = jsPolygon;
    } else {
      polygonRefs[polygon.id]?.setOptions(PolygonOptions(
        paths: js_util.jsify(polygon.points) as JSAny,
      ));
    }
  }

  if(editPolygon) {
    moveToPolygon(gMap, polygons.first);

    polygonRefs.values.first.enableEditing((points) {
      onPolygonCreated!(points);
    });
  }
}