import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'models.dart';

class CityMap extends StatelessWidget {
  CityMap({this.city});
  final City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Center(child: Map(city: city)),
    );
  }
}

class Map extends StatelessWidget {
  Map({this.city});
  final City city;

  Widget build(BuildContext context) {
    final point = LatLng(city.lat, city.long);
    final markers = [
      Marker(
        width: 100.0,
        height: 100.0,
        point: point,
        builder: (ctx) => new Container(
          // child: ClipOval(
            child: Image.asset(
              "images/" + city.imageName + ".jpeg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          // ),
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
          // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          urlTemplate: "http://a.tile.stamen.com/toner/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          // wmsOptions: WMSTileLayerOptions(
          //   baseUrl: "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
          //   // layers: ["nexrad-n0r-900913"],
          //   // format: "image/png",
          //   // transparent: true,
          //   )
        ),
        MarkerLayerOptions(markers: markers),
        PolylineLayerOptions(polylineCulling: true),
      ],
    );
  }
}
