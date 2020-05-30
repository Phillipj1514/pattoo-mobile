import 'package:flutter/material.dart';
import 'package:pattoomobile/utils/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeManager with ChangeNotifier {
 ThemeData _themeData;
  final _kThemePreference = "theme_preference";
 /// Use this method on UI to get selected theme.
 ThemeData get themeData {
   if (_themeData == null) {
     _themeData = appThemeData[AppTheme.Light];
   }
   return _themeData;
 }

 ThemeManager() {
   // We load theme at the start
   _loadTheme();
 }

 
 /// Sets theme and notifies listeners about change. 
 setTheme(AppTheme theme) async {
   _themeData = appThemeData[theme];
   var prefs = await SharedPreferences.getInstance();
   prefs.setInt(_kThemePreference, AppTheme.values.indexOf(theme));
   // Here we notify listeners that theme changed 
   // so UI have to be rebuild
   notifyListeners();
 }



 void _loadTheme() {
   debugPrint("Entered loadTheme()");
   SharedPreferences.getInstance().then((prefs) {
     int preferredTheme = prefs.getInt(_kThemePreference) ?? 0;
     _themeData = appThemeData[AppTheme.values[preferredTheme]];
     // Once theme is loaded - notify listeners to update UI
     notifyListeners();
   });
 }



}