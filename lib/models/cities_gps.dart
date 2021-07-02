// To parse this JSON data, do
//
//     final citiesGps = citiesGpsFromJson(jsonString);

// In this file, the location is on Serang, Banten, Indonesia

import 'dart:convert';

CitiesGps citiesGpsFromJson(String str) => CitiesGps.fromJson(json.decode(str));

String citiesGpsToJson(CitiesGps data) => json.encode(data.toJson());

class CitiesGps {
  CitiesGps({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory CitiesGps.fromJson(Map<String, dynamic> json) => CitiesGps(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.city,
    this.state,
    this.country,
    this.location,
    this.current,
  });

  String city;
  String state;
  String country;
  Location location;
  Current current;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Current {
  Current({
    this.weather,
    this.pollution,
  });

  Weather weather;
  Pollution pollution;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        weather: Weather.fromJson(json["weather"]),
        pollution: Pollution.fromJson(json["pollution"]),
      );

  Map<String, dynamic> toJson() => {
        "weather": weather.toJson(),
        "pollution": pollution.toJson(),
      };
}

class Pollution {
  Pollution({
    this.ts,
    this.aqius,
    this.mainus,
    this.aqicn,
    this.maincn,
  });

  DateTime ts;
  int aqius;
  String mainus;
  int aqicn;
  String maincn;

  factory Pollution.fromJson(Map<String, dynamic> json) => Pollution(
        ts: DateTime.parse(json["ts"]),
        aqius: json["aqius"],
        mainus: json["mainus"],
        aqicn: json["aqicn"],
        maincn: json["maincn"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts.toIso8601String(),
        "aqius": aqius,
        "mainus": mainus,
        "aqicn": aqicn,
        "maincn": maincn,
      };
}

class Weather {
  Weather({
    this.ts,
    this.tp,
    this.pr,
    this.hu,
    this.ws,
    this.wd,
    this.ic,
  });

  DateTime ts;
  int tp;
  int pr;
  int hu;
  double ws;
  int wd;
  String ic;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        ts: DateTime.parse(json["ts"]),
        tp: json["tp"],
        pr: json["pr"],
        hu: json["hu"],
        ws: json["ws"].toDouble(),
        wd: json["wd"],
        ic: json["ic"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts.toIso8601String(),
        "tp": tp,
        "pr": pr,
        "hu": hu,
        "ws": ws,
        "wd": wd,
        "ic": ic,
      };
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
