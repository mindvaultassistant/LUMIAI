import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleRuntime extends InheritedNotifier<ValueNotifier<Locale>> {
  LocaleRuntime({super.key, required Widget child})
    : super(notifier: _notifier, child: child);

  static const String prefKey = "app_locale_v1";
  static final ValueNotifier<Locale> _notifier = ValueNotifier<Locale>(
    const Locale('tr'),
  );

  static Locale localeOf(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<LocaleRuntime>()
          ?.notifier
          ?.value ??
      _notifier.value;

  static Locale get current => _notifier.value;

  static Future<void> init() async {
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString(prefKey) ?? 'tr';
    _notifier.value = Locale(code);
  }

  static Future<void> set(String code) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(prefKey, code);
    _notifier.value = Locale(code);
  }
}
