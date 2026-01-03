// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'LumiAI';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageTitle => 'Dil';

  @override
  String get account => 'Hesap';

  @override
  String get guestNotSignedIn => 'Misafir / Giriş yapılmadı';

  @override
  String get actions => 'İşlemler';

  @override
  String get signOut => 'Çıkış yap';

  @override
  String get exitGuest => 'Misafirden çık';

  @override
  String get generate => 'Üret';

  @override
  String get coins => 'Coin';

  @override
  String get yourBalance => 'Bakiye';
}
