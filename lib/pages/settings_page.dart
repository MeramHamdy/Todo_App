import 'package:app1/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
      ),
      body: SwitchWidget(),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemesProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Text(
                themeProvider.isDarkMode? 'Light Mode':'Dark Mode',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {themeProvider.toggleThem();},
                activeColor: Colors.green,
                activeTrackColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
