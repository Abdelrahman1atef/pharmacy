import 'package:flutter/material.dart';

import 'cashe_helper.dart';


class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String appLang = CashHelper.getData(key: 'lang') ?? 'ar';

  AppConfigProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    String? savedMode = await CashHelper.getThemeMode();
    if (savedMode != null) {
      appTheme = savedMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> changeTheme(ThemeMode newMode) async {
    if (appTheme == newMode) {
      return;
    } else {
      appTheme = newMode;
      await CashHelper.saveThemeMode(newMode == ThemeMode.dark ? 'dark' : 'light');
      notifyListeners();
    }
  }

  Future<void> changeLang(String newLang) async {
    if (appLang == newLang) {
      return;
    } else {
      appLang = newLang;
      await CashHelper.saveData(key: 'lang', value: newLang);
      notifyListeners();
    }
  }
}
