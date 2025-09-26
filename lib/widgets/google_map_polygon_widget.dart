import '../src/internal/utils/render_polygons.dart';
import '../src/internal_use_library.dart';

class GoogleMapPolygon extends StatefulWidget {
  final GoogleMapPolygonController mapController;
  final CameraPosition initialCameraPosition;
  final double mapWidth;
  final double mapHeight;
  final List<PolygonData>? polygons;
  final PolygonData? singlePolygon;
  final bool returnAsWKT;
  final void Function(dynamic value)? onPolygonCreated;
  final void Function(dynamic value)? onPolygonEdited;
  final String mapId;
  final String mapKey;
  final bool editPolygon;

  GoogleMapPolygon({
    super.key,
    required this.mapId,
    required this.mapKey,
    required this.mapController,
    required this.initialCameraPosition,
    this.mapHeight = 300,
    this.mapWidth = double.infinity,
    this.polygons,
    this.singlePolygon,
    this.returnAsWKT = false,
    this.onPolygonCreated,
    this.editPolygon = false,
    this.onPolygonEdited,
  }) : assert((polygons == null && singlePolygon == null) || (polygons != null && singlePolygon == null) || (polygons == null && singlePolygon != null), 'Can\'t provide both list and a single polygon. Either one or both should be null'),
        assert(polygons == null || polygons.map((p) => p.id).toSet().length == polygons.length, 'Duplicate polygon IDs found in the polygons list', ),
        assert(mapId.isNotEmpty, 'Map ID can\'t be empty. Head to Google cloud console and get one from Map Styles'),
        assert((editPolygon == true && singlePolygon != null && polygons == null) || (editPolygon == false && singlePolygon == null && polygons != null), 'Editing a polygon requires a single polygon data. And the polygon list to be null');

  @override
  State<GoogleMapPolygon> createState() => _GoogleMapPolygonState();
}

class _GoogleMapPolygonState extends State<GoogleMapPolygon> {
  late final String _mapDivId;
  late final String _viewType;
  late DrawingManager drawingManager;
  bool _mapReady = false;
  GMap? _gMap;
  Map<String, Polygon> polygonRefs = {};

  bool polygonCreated = false;
  List<PolygonData>? _pendingPolygons;

  @override
  void didUpdateWidget(covariant GoogleMapPolygon oldWidget) {
      if (_mapReady && _gMap != null) {
        renderPolygons(
          polygons: widget.polygons != null ? widget.polygons! : widget.singlePolygon != null ? [widget.singlePolygon!] : [],
          polygonRefs: polygonRefs,
          gMap: _gMap!,
          editPolygon: widget.editPolygon,
          onPolygonCreated: widget.onPolygonEdited
        );
      } else {
        if(widget.polygons != oldWidget.polygons) _pendingPolygons = widget.polygons;
        if(widget.singlePolygon != oldWidget.singlePolygon) _pendingPolygons = [widget.singlePolygon!];
      }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _mapDivId = 'map-container-$timestamp';
    _viewType = 'google-map-view-$timestamp';

    if(kIsWeb) _registerWebViewAndCallLoadingScript(widget.mapKey, widget.mapId);

  }

  /// Calls the Google Map loading scripts and register web view
  void _registerWebViewAndCallLoadingScript(String mapKey, String mapId) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await loadGoogleMapsScript(mapKey);

        registerWebView(_viewType, (int viewId) {
          final container = buildMapView(
            mapDivId: _mapDivId,
            initialCameraPosition: widget.initialCameraPosition,
            editPolygon: widget.editPolygon,
            gMapSetter: (map) {
              _gMap = map;
              renderPolygons(
                  polygons: widget.polygons != null ? widget.polygons! : widget.singlePolygon != null ? [widget.singlePolygon!] : [],
                  polygonRefs: polygonRefs,
                  gMap: _gMap!,
                  editPolygon: widget.editPolygon,
                  onPolygonCreated: widget.onPolygonEdited
              );
              _pendingPolygons = null;
            },
            mapId: mapId,
            isPolygonCreated: () => polygonCreated,
            controller: widget.mapController,
            returnAsWKT: widget.returnAsWKT,
            onPolygonCreated: widget.onPolygonCreated,
          );
          return container;
        });

        if (mounted) {

          setState(() {
            _mapReady = true;
          });

          if (_pendingPolygons != null && _gMap != null) {
            renderPolygons(
              polygons: _pendingPolygons!,
              polygonRefs: polygonRefs,
              gMap: _gMap!,
                onPolygonCreated: widget.onPolygonEdited
            );
            _pendingPolygons = null;
          }

        }
      } catch (e) {
        throw Exception('Google Maps script failed to load: $e');
      }
    });
  }

  @override
  void dispose() {
    removeMapDiv(_mapDivId);
    widget.mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!_mapReady) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: widget.mapWidth < 250 ? MediaQuery.sizeOf(context).width * 0.2 : widget.mapWidth,
      height: widget.mapHeight < 200 ? 250 : widget.mapHeight,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}