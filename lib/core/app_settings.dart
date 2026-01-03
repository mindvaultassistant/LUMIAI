import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const _kThemeMode = 'theme_mode'; // 0 system, 1 light, 2 dark
  static const _kLocale = 'locale_code';   // "tr", "en", ...

  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final tm = prefs.getInt(_kThemeMode) ?? 0;
    _themeMode = switch (tm) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final code = prefs.getString(_kLocale);
    _locale = (code == null || code.isEmpty) ? null : Locale(code);

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final v = switch (mode) {
      ThemeMode.light => 1,
      ThemeMode.dark => 2,
      _ => 0,
    };
    await prefs.setInt(_kThemeMode, v);
  }

  Future<void> setLocale(Locale? loc) async {
    _locale = loc;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (loc == null) {
      await prefs.remove(_kLocale);
    } else {
      await prefs.setString(_kLocale, loc.languageCode);
    }
  }
}
