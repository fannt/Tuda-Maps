import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'models.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
// import 'package:maps_launcher/maps_launcher.dart';

class CityMap extends StatefulWidget {
  CityMap({this.city});
  final City city;

  @override
  _CityMapState createState() => _CityMapState(city: city);
}

class _CityMapState extends State<CityMap> {
  _CityMapState({@required this.city, this.pins});
  _CityMapState copyWith({City city, List pins}) {
    return _CityMapState(city: city ?? this.city, pins: pins ?? this.pins);
  }

  final City city;
  List pins;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final newPins = await loadJson(city.name);
      // this = this.copyWith(pins: newPins);
      setState(() {
        pins = newPins;
      });
    });
  }

  Future<List> loadJson(String name) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/" + city.name + ".json");
    final jsonResult = json.decode(data);
    // debugPrint(jsonResult.toString());
    return jsonResult;
  }

  @override
  Widget build(BuildContext context) {
    final point = LatLng(city.lat, city.long);
    final markers =
        pins?.map((pin) => createMarker(context, pin))?.toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.name),
      ),
      body: Center(
          child: FlutterMap(
        options: MapOptions(
          center: point,
          zoom: 12.0,
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
      )),
    );
  }

  Marker createMarker(context, pin) {
    final point = LatLng(pin["latitute"], pin["longitude"]);
    return Marker(
        width: 60.0,
        height: 60.0,
        point: point,
        builder: (ctx) => createPin(context, pin));
  }

  Widget createPin(context, pin) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildAboutDialog(context, pin),
        );
      },
      child: Container(
        child: Stack(alignment: Alignment.topCenter, children: [
          SvgPicture.asset("assets/icons/pin.svg"),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ClipOval(
              child: Image.asset(
                "assets/images/" + pin["work_photo_name"] + ".jpg",
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _buildAboutDialog(BuildContext context, pin) {
  return new AlertDialog(
    title: Text(pin["work_name"]),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset("assets/images/" + pin["work_photo_name"] + ".jpg"),
        Container(height: 8),
        Text("Architect(s): " + pin["architect"],
            style: TextStyle(fontSize: 11)),
        Container(height: 12),
        Text("Year completed: " + pin["year_completed"].toString(),
            style: TextStyle(fontSize: 11)),
        Container(height: 12),
        GestureDetector(
          onTap: () {
            // debugPrint("sds");
            MapsLauncher.launchCoordinates(pin["latitute"], pin["longitude"]);
          },
          child: Text(pin["address"].toString(),
              style: TextStyle(
                  fontSize: 11,
                  color: Color.fromARGB(255, 0, 0, 255),
                  decoration: TextDecoration.underline)),
        ),
      ],
    ),
  );
}
