import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier{
  bool _isdarkmode=true;
  bool get isDarkMode=>_isdarkmode;
  ThemeMode get currentTheme=>_isdarkmode?ThemeMode.dark:ThemeMode.light;
  void toggletheme(){
    _isdarkmode=!_isdarkmode;
    notifyListeners();
  }
}