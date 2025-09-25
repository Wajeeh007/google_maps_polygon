part of '../../internal_use_library.dart';

html.Element buildMapView({
  required String mapDivId,
  required void Function(GMap map) gMapSetter,
  required String mapId,
  required bool Function() isPolygonCreated,
  required GoogleMapPolygonController controller,
  required CameraPosition initialCameraPosition,
  required bool returnAsWKT,
  required void Function(dynamic value)? onPolygonCreated,
  bool editPolygon = false,
}) {
  final container = html.DivElement()
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.position = 'relative';

  final mapDiv = html.DivElement()
    ..id = mapDivId
    ..style.width = '100%'
    ..style.height = '100%';

  container.append(mapDiv);

  final mapOptions = MapOptions(
    center: initialCameraPosition.initialCoords,
    zoom: initialCameraPosition.zoom,
    mapId: mapId,
  );

  final gMap = GMap(mapDiv as JSAny, mapOptions as JSAny);
  gMapSetter(gMap);
  final rawMap = gMap as JSObject;

  dynamic activePolygon;

  bindClearPolygon(controller, () {
    if (activePolygon != null) {
      js_util.callMethod(activePolygon, 'setMap', [null]);
      activePolygon = null;
    }
  });

  final drawingOpts = DrawingManagerOptions(
    drawingMode: null,
    drawingControl: false,
    polygonOptions: js_util.jsify({
      'fillColor': '#FF0000',
      'fillOpacity': 0.5,
      'strokeWeight': 1.5,
      'clickable': false,
      'editable': true,
      'zIndex': 1,
    }),
  );

  final drawingManager = DrawingManager(drawingOpts)..setMap(gMap);

  _setPolygonData(
    drawingManager: drawingManager,
    isPolygonCreated: isPolygonCreated,
    onPolygonCreated: (points, overlay) {
      activePolygon = overlay;

      if (onPolygonCreated != null) {
        if (returnAsWKT) {
          final polygon = 'POLYGON((${points.join(', ')}))';
          onPolygonCreated(polygon);
        } else {
          onPolygonCreated(points);
        }
      }
    },
  );

  if(!editPolygon) {
    _drawUiButtons(
      rawMap: rawMap,
      gMap: gMap,
      container: container,
      mapDiv: mapDiv,
      drawingManager: drawingManager,
      isPolygonCreated: isPolygonCreated,
      controller: controller,
    );
  }

  return container;
}
