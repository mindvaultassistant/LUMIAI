import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController._(this._prefs, this._locale);

  static const String _kKey = 'app_locale_code';

  final SharedPreferences _prefs;
  Locale _locale;

  Locale get locale => _locale;

  static Future<LocaleController> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kKey);
    final locale = (code == null || code.trim().isEmpty) ? null : Locale(code);
    return LocaleController._(prefs, locale ?? const Locale('en'));
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale.languageCode.toLowerCase() == locale.languageCode.toLowerCase())
      return;
    _locale = Locale(locale.languageCode);
    await _prefs.setString(_kKey, _locale.languageCode);
    notifyListeners();
  }

  Future<void> clearOverride() async {
    await _prefs.remove(_kKey);
    notifyListeners();
  }
}
