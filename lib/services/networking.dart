import 'package:http/http.dart';
import 'dart:convert';

const String apiKey = '69c9e62930030ee02c4209626b309a56';
const String openWeatherAPIURL =
    'https://api.openweathermap.org/data/2.5/weather';

class OpenWeatherAPI {
  Future<dynamic> getWeather(double latitude, double longitude) async {
    Network network = Network(
        '$openWeatherAPIURL?lat=$latitude&lon=$longitude&APPID=$apiKey&units=metric');
    var data = await network.getData();
    return data;
  }

  Future<dynamic> getWeatherByCity(String city) async {
    Network network =
        Network('$openWeatherAPIURL?q=$city&APPID=$apiKey&units=metric');
    var data = await network.getData();
    return data;
  }
}

class Network {
  final String url;

  Network(this.url);

  Future getData() async {
    print('calling uri: $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      print('starting loading data');
      var data = jsonDecode(response.body);
      return data;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post ${response.statusCode}');
    }
  }
}
