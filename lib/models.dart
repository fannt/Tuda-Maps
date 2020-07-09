final cities = [
  City(
      name: "Almaty",
      imageName: "Almaty.jpeg",
      lat: 43.2405801,
      long: 76.9201516),
  City(
      name: "Bishkek",
      imageName: "Bishkek.jpeg",
      lat: 42.8785619,
      long: 74.6017189),
  City(
      name: "Chemnitz",
      imageName: "Chemnitz.jpeg",
      lat: 42.8785619,
      long: 74.6017189),
];

class City {
  City({this.name, this.imageName, this.lat, this.long});
  String name;
  String imageName;
  double lat;
  double long;
}
