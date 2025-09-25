part of '../map_controller.dart';

void bindClearPolygon(
    GoogleMapPolygonController controller,
    void Function() clearPolygonImpl,
    ) {
  controller._internal._clearPolygon = clearPolygonImpl;
}
