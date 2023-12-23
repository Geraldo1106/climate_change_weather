import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:climate_change_weather/services/networking.dart';
import 'package:flutter/foundation.dart';

import 'location.dart';

const apiKey = 'e72ca729af228beabd5d20e3b7749713';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // Get weather data for a specific city
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching city weather: $e');
      }
      // You might want to handle the error more gracefully, e.g., return an error message.
      return null;
    }
  }

  // Get weather data based on the current location
  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching location weather: $e');
      }
      // You might want to handle the error more gracefully, e.g., return an error message.
      return null;
    }
  }

  // Get weather icon based on weather condition code
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

  // Get a weather-related message based on temperature
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
