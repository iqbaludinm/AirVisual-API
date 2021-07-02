import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Specified {
  String city;
  String state;
  String country;

  Specified({this.city, this.state, this.country});

  factory Specified.createSpecified(Map<String, dynamic> object) {
    // object adalah nama Object dari JSON Object
    return Specified(
        city: object['city'],
        state: object['state'],
        country: object['country']);
  }

  static Future<Specified> connectToAPI(String state, String country) async {
    String apiURL = "http://api.airvisual.com";
    String apiKey = "435364ec-45c8-43d8-a546-cba558bc5767";
    // String state = "California";
    // String country = "USA";
    String requestURL =
        "$apiURL/v2/city?city=Los%20Angeles&state=$state&country=$country&key=$apiKey";

    var response = await http.get(Uri.parse(requestURL));
    var jsonObject = json.decode(response.body);

    var specifiedData = (jsonObject
        as Map<String, dynamic>)['data']; //mengeluarkan isi dari data

    return Specified.createSpecified(specifiedData);

    // if (response.statusCode == 200) {
    //   return Specified.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception("Eror loading request URL Info.");
    // }
  }

  // static Future<List<Specified>> getSpecified(
  //     String state, String country) async {
  //   String apiURL = "http://api.airvisual.com";
  //   String apiKey = "435364ec-45c8-43d8-a546-cba558bc5767";
  //   // String state = "California";
  //   // String country = "USA";
  //   String requestURL =
  //       "${apiURL}/v2/city?city=Los%20Angeles&state=${state}&country=${country}&key=${apiKey}";

  //   var response = await http.get(Uri.parse(requestURL));
  //   var jsonObject = json.decode(response.body);
  //   List<dynamic> listData = (jsonObject as Map<String, dynamic>)['data'];

  //   List<Specified> specified = [];
  //   for (int i = 0; i < listData.length; i++) {
  //     specified.add(Specified.createSpecified(listData[i]));
  //     return specified;
  //   }
  // }
}
