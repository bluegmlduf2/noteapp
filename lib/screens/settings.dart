import 'package:flutter/material.dart';
import '../services/sharedPref.dart';

class SettingsPage extends StatelessWidget {
  final Function(Brightness brightness) changeTheme;

  const SettingsPage({super.key, required this.changeTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light Theme'),
            onTap: () => _setTheme(Brightness.light),
          ),
          ListTile(
            title: const Text('Dark Theme'),
            onTap: () => _setTheme(Brightness.dark),
          ),
        ],
      ),
    );
  }

  void _setTheme(Brightness brightness) {
    setThemeinSharedPref(brightness == Brightness.light ? 'light' : 'dark');
    changeTheme(brightness);
  }
}
