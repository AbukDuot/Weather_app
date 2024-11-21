import 'package:flutter/material.dart';
import 'weather_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Fixed background image at the top
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Welcome to Weather App!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Subheading and Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Explore real-time weather updates and forecasts',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Search Weather',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Scrolling images
          Expanded(
            child: ListView(
              children: [
                Image.asset('assets/images/image3.jpg', height: 200, fit: BoxFit.cover),
                SizedBox(height: 10),
                Image.asset('assets/images/image1.jpg', height: 200, fit: BoxFit.cover),
                SizedBox(height: 10),
                Image.asset('assets/images/image2.jpg', height: 200, fit: BoxFit.cover),
              ],
            ),
          ),
        ],
      ),

      // Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
            );
          }
        },
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}