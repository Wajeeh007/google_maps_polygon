part of '../../internal_use_library.dart';

/// Draw UI buttons on the map inside a toolbar
void _drawUiButtons({
  required dynamic rawMap,
  required GMap gMap,
  required html.DivElement container,
  required html.DivElement mapDiv,
  required DrawingManager drawingManager,
  required bool Function() isPolygonCreated,
  required GoogleMapPolygonController controller,
  bool willDraw = true,
  bool editPolygon = false,
}) {
  if (willDraw) {
    /// Toolbar container
    final toolbar = html.DivElement()
      ..style.position = 'absolute'
      ..style.top = '9.5px'
      ..style.right = '60px'
      ..style.zIndex = '5'
      ..style.display = 'flex'
      ..style.flexDirection = 'row'
      ..style.gap = '8px'
      ..style.padding = '6px'
      ..style.backgroundColor = 'rgba(255, 255, 255, 0.9)'
      ..style.border = '1px solid #ccc'
      ..style.borderRadius = '6px'
      ..style.boxShadow = '0 2px 6px rgba(0,0,0,0.2)';

    /// Buttons
    final drawButton = html.ButtonElement()
      ..text = '✏️'
      ..title = 'Draw Polygon'
      ..style.cursor = 'pointer';

    final dragButton = html.ButtonElement()
      ..text = '🧭'
      ..title = 'Pan/Drag'
      ..style.cursor = 'pointer';

    final cancelButton = html.ButtonElement()
      ..text = '❌'
      ..title = 'Clear Polygon'
      ..style.cursor = 'pointer';

    // final locateButton = html.ButtonElement()
    //   ..text = '📍'
    //   ..style.position = 'absolute'
    //   ..style.top = '10px'
    //   ..style.right = '60px'
    //   ..style.zIndex = '5';

    cancelButton.onClick.listen((_) {
      drawingManager.setDrawingMode(null);
      controller.clearPolygon();
    });

    dragButton.onClick.listen((_) {
      drawingManager.setDrawingMode(null);
      mapDiv.style.pointerEvents = 'auto';
    });

    drawButton.onClick.listen((_) {
      if (isPolygonCreated()) {
        html.window.alert(
          'A polygon already exists. Delete it before drawing another.',
        );
        return;
      }
      drawingManager.setDrawingMode('polygon');
      mapDiv.style.pointerEvents = 'auto';
    });

    // locateButton.onClick.listen((_) {
    //   moveCamera(gMap, rawMap);
    // });

    toolbar.append(drawButton);
    toolbar.append(dragButton);
    if (!editPolygon) toolbar.append(cancelButton);

    container.append(toolbar);
  }
}