import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  static const _key = 'app_locale';
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString(_key);
    if (code != null) _locale = Locale(code);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_key, locale.languageCode);
    _locale = locale;
    notifyListeners();
  }
}
