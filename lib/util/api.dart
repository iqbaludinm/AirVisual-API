import 'package:http/http.dart' as http;
import 'package:request_api/models/cities_gps.dart';
import 'package:request_api/models/weather_model.dart';

Future<WeatherModel> fetchWeather(
    {String city, String state, String country, WeatherModel dataTemp}) async {
  String apiURL = "https://api.airvisual.com/";
  String apiKey = "435364ec-45c8-43d8-a546-cba558bc5767";
  String requestURL =
      "${apiURL}v2/city?city=$city&state=$state&country=$country&key=$apiKey";

  final response = await http.get(Uri.parse(requestURL));
  print(response.statusCode);
  if (response.statusCode == 200) {
    // var res = json.decode(response.body);
    var data = weatherModelFromJson(response.body);
    print(response.body);
    return data;
  } else {
    if (dataTemp != null) {
      return dataTemp;
    } else {
      throw Exception('Failed of loading data');
    }
  }
}

Future<CitiesGps> currentLoc(double long, double lat) async {
  String apiURL = "https://api.airvisual.com/";
  String apiKey = "435364ec-45c8-43d8-a546-cba558bc5767";
  String requestURL = "${apiURL}v2/nearest_city?lat=$long&lon=$lat&key=$apiKey";

  final response = await http.get(Uri.parse(requestURL));
  print(response.statusCode);
  if (response.statusCode == 200) {
    var data_2 = citiesGpsFromJson(response.body);
    print(response.body);
    return data_2;
  } else {
    throw Exception('Failed of loading data');
  }
}
