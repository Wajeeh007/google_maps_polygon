import 'package:flutter/material.dart';
import 'package:google_maps_polygon/google_map_polygon.dart';
import 'package:google_maps_polygon/models/camera_position.dart';
import 'package:google_maps_polygon/models/lat_lng.dart';
import 'package:google_maps_polygon/models/polygon_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Polygon JS Implementation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PolygonData> polygons = [];

  @override
  void initState() {
    polygons.addAll([
      PolygonData(
        id: 'zone1',
        points: [
          LatLng(34.13323942598082, 71.1073298385321),
          LatLng(33.9192659849147, 70.56076001431335),
          LatLng(33.72303111875004, 71.0908503463446),
          LatLng(34.08093409078901, 71.41769360806335),
          LatLng(34.04908023241135, 71.2721247604071),
          LatLng(34.14460587121248, 71.20346020962585),
          LatLng(34.13323942598082, 71.1073298385321)],
      ),
      PolygonData(
        id: 'zone2',
        points: [
          LatLng(34.030, 71.060),
          LatLng(33.9192659849147, 70.56076001431335),
          LatLng(33.72303111875004, 71.0908503463446),
          LatLng(34.08093409078901, 71.41769360806335),
          LatLng(34.04908023241135, 71.2721247604071),
          LatLng(34.14460587121248, 71.20346020962585),
          LatLng(34.13323942598082, 71.1073298385321)],
      ),
    ],);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is your map with polygons'),
            GoogleMapPolygon(
              mapWidth: 300,
              polygons: polygons,
              mapController: GoogleMapPolygonController(),
              mapId: '[YOUR-MAP-ID]',
              mapKey: '[YOUR-MAP-KEY]',
              initialCameraPosition: CameraPosition(initialCoords: LatLng(38.899236, -77.036693)),
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondScreen()
                    )
                ),
                child: Text(
                    'Edit a polygon'
                )
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Edit this polygon'),
            GoogleMapPolygon(
              singlePolygon: PolygonData(
                id: 'zone2',
                points: [
                  LatLng(34.030, 71.060),
                  LatLng(33.9192659849147, 70.56076001431335),
                  LatLng(33.72303111875004, 71.0908503463446),
                  LatLng(34.08093409078901, 71.41769360806335),
                  LatLng(34.04908023241135, 71.2721247604071),
                  LatLng(34.14460587121248, 71.20346020962585),
                  LatLng(34.13323942598082, 71.1073298385321)],
              ),
              mapController: GoogleMapPolygonController(),
              mapId: '[YOUR-MAP-ID]',
              mapKey: '[YOUR-MAP-KEY]',
              onPolygonEdited: (value) {
                print(value);
              },
              editPolygon: true,
              initialCameraPosition: CameraPosition(initialCoords: LatLng(38.899236, -77.036693)),
            )
          ],
        ),
      ),
    );
  }
}