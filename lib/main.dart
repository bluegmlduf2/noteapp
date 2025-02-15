import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'data/theme.dart';
import 'services/sharedPref.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme = appThemeLight;

  @override
  void initState() {
    super.initState();
    updateThemeFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MyHomePage(changeTheme: setTheme),
    );
  }

  void setTheme(Brightness brightness) {
    setState(() {
      theme = brightness == Brightness.dark ? appThemeDark : appThemeLight;
    });
  }

  void updateThemeFromSharedPref() async {
    String themeText = await getThemeFromSharedPref();
    setTheme(themeText == 'light' ? Brightness.light : Brightness.dark);
  }
}
