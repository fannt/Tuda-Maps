import 'package:flutter/material.dart';
import 'city_map.dart';
import 'models.dart';

void main() => runApp(MaterialApp(
      title: 'Navigation Basics',
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function onTap = (City city) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CityMap(city: city)));
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Tuda'),
      ),
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: cities.map((city) => createCityCard(city, onTap)).toList(),
      )),
    );
  }

  Widget createCityCard(City city, Function(City) onTap) => Container(
        child: GestureDetector(
          onTap: () {
            onTap(city);
            // debugPrint(city.name);
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      city.name,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 6,
                    child: Image.asset(
                      "assets/images/" + city.imageName,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )),
        ),
      );
}
