import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String openWeatherApiKey = '30043d9564147a9d80792ad582cbe5e8'; // Your API key

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController _searchController = TextEditingController();
  String _city = '';
  String _temperature = '';
  String _description = '';
  String _errorMessage = '';

  Future<void> _fetchWeather() async {
    final city = _searchController.text.trim();
    if (city.isEmpty) return;

    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherApiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _city = data['name'];
          _temperature = '${data['main']['temp']} °C';
          _description = data['weather'][0]['description'];
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage = 'City not found. Try another search.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search City',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            SizedBox(height: 20),
            _errorMessage.isNotEmpty
                ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Column(
                    children: [
                      if (_city.isNotEmpty)
                        Text(
                          _city,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (_temperature.isNotEmpty)
                        Text(
                          _temperature,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (_description.isNotEmpty)
                        Text(
                          _description,
                          style: TextStyle(fontSize: 20),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}