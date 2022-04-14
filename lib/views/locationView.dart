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
                    point: LatLng(-21.23340, 27.49347),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on, color: Colors.red),
                        tooltip: 'Francistown Academic Hospital',
                        onPressed: () {}),
                  ),
                ]),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-21.16161, 27.51285),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on, color: Colors.red),
                        tooltip: 'RiverSide Hospital',
                        onPressed: () {}),
                  ),
                ]),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-24.54842, 25.83984),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on, color: Colors.red),
                        tooltip: 'Lenmed Bokamoso Clinic',
                        onPressed: () {}),
                  ),
                ]),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-24.62798, 25.93361),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on),
                        tooltip: 'Life Gaborone Hospital',
                        onPressed: () {}),
                  ),
                ]),
                MarkerLayerOptions(markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(-24.66030, 25.93084),
                    builder: (context) => IconButton(
                        icon: const Icon(Icons.location_on),
                        tooltip: 'University of Botswana',
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
