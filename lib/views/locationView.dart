import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Center'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
              options:
                  MapOptions(maxZoom: 7.0, center: LatLng(-21.759, 24.214)),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-24.66215, 25.93275),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on),
                        tooltip: 'Testing Centers',
                        onPressed: () {}),
                  ),
                ]),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-20.66215, 25.93275),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on),
                        tooltip: 'Vaccination Centers',
                        onPressed: () {}),
                  ),
                ]),
              ])
        ],
      ),
    );
  }
}
