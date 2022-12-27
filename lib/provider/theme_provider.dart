import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = temaDia();

  getthemeData() => this._themeData;
  setthemeData(ThemeData theme){
    this._themeData = theme;
    notifyListeners();
  }
}