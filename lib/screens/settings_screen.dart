import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: toggleTheme,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Implement your notification logic here
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Weather App',
                applicationVersion: '1.0.0',
                children: [
                  Text('This app provides real-time weather updates.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}