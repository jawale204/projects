import 'package:clima/location.dart';
import 'package:clima/services/networking.dart';
const apikey='c453306cd0235f6292a3579f6647afab'; 

class WeatherModel {

  Future<String> getCityWeather(cityName) async{
    NetworkHelper network=  NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric');
    String cityData= await network.getData();
      return cityData;
  }

Future<String> getWeatherData()async{
    print('yppoopp');
    Location loc= Location();
     await loc.getCurrentLocation();
     NetworkHelper net=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apikey&units=metric');
      String Data= await net.getData();

      return (Data);

    }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
