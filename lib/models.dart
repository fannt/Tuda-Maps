
final cities = [
      City(name: "Almaty", imageName:"Almaty", lat: 42.8785619, long:74.6017189),
      City(name: "Bishkek", imageName:"Bishkek", lat: 42.8785619, long:74.6017189),
      City(name: "Chemnitz", imageName:"Chemnitz", lat: 42.8785619, long:74.6017189),
    ];

class City {
  City({this.name, this.imageName, this.lat, this.long});
  String name;
  String imageName;
  double lat;
  double long;
}