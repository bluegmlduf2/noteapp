import 'package:shared_preferences/shared_preferences.dart';

Future<String> getThemeFromSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return sharedPref.getString('theme') ?? '';
}

Future<void> setThemeinSharedPref(String val) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString('theme', val);
}
