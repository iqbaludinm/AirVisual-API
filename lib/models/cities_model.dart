// To parse this JSON data, do
//
//     final citiesIndonesia = citiesIndonesiaFromJson(jsonString);

import 'dart:convert';

CitiesIndonesia citiesIndonesiaFromJson(String str) =>
    CitiesIndonesia.fromJson(json.decode(str));

String citiesIndonesiaToJson(CitiesIndonesia data) =>
    json.encode(data.toJson());

class CitiesIndonesia {
  CitiesIndonesia({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory CitiesIndonesia.fromJson(Map<String, dynamic> json) =>
      CitiesIndonesia(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.state,
  });

  String state;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
      };
}
