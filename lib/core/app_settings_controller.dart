import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_settings.dart';

class AppSettingsController extends ValueNotifier<AppSettings> {
  static const _kPrefsKey = "lumi_app_settings_v1";
  final SharedPreferences _prefs;

  AppSettingsController(this._prefs, AppSettings initial) : super(initial);

  static Future<AppSettingsController> create() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kPrefsKey);
    if (raw == null || raw.isEmpty) {
      return AppSettingsController(prefs, AppSettings.defaults);
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AppSettingsController(prefs, AppSettings.fromJson(map));
    } catch (_) {
      return AppSettingsController(prefs, AppSettings.defaults);
    }
  }

  Future<void> _save() async {
    await _prefs.setString(_kPrefsKey, jsonEncode(value.toJson()));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    value = value.copyWith(themeMode: mode);
    await _save();
  }

  Future<void> setLocale(Locale? locale) async {
    value = value.copyWith(locale: locale, clearLocale: locale == null);
    await _save();
  }

  Future<void> setLastAuth(String lastAuth) async {
    value = value.copyWith(lastAuth: lastAuth);
    await _save();
  }
}
