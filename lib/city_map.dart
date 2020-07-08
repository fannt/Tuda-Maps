import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class CityMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bishkek"),
      ),
      body: Center(child: Map()),
    );
  }
}

class Map extends StatelessWidget {
  Widget build(BuildContext context) {
    final point = LatLng(42.8785619, 74.6017189);
    final markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        builder: (ctx) => new Container(
          child: Image.asset(
            "images/Bishkek.jpeg",
            // fit: BoxFit.cover,
          ),
        ),
      ),
    ];
    return FlutterMap(
      options: MapOptions(
        center: point,
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          // wmsOptions: WMSTileLayerOptions(
          //   baseUrl: "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
          //   layers: ["nexrad-n0r-900913"], 
          //   format: "image/png",
          //   // transparent: true,
          //   )
        ),
        MarkerLayerOptions(markers: markers),
        PolylineLayerOptions(polylineCulling: true),
      ],
    );
  }
}
