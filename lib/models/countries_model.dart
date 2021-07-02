// To parse this JSON data, do
//
//     final CountriesModel = CountriesModelFromJson(jsonString);

import 'dart:convert';

CountriesModel countriesModelFromJson(String str) =>
    CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
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
    this.country,
  });

  String country;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}
