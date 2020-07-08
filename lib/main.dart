import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cities = ["Almaty", "Bishkek", "Chemnitz"];
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tuda'),
        ),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        body: Center(
            child: ListView(
          padding: const EdgeInsets.all(8),
          children: cities.map(createCityCard).toList(),
        )),
      ),
    );
  }

  Widget createCityCard(String cityName) => Container(
        child: GestureDetector(
          onTap: () => debugPrint(cityName),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cityName,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 6,
                    child: Image.asset(
                      "images/" + cityName + ".jpeg",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )),
        ),
      );
}
