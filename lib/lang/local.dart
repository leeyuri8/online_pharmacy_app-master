import 'dart:ui';
import '../backend/firebase.dart';
import '../lang/ar_uae.dart';
import 'package:get/get.dart';
import 'en_usa.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('ar', 'UAE');
  static final langs = ['English', 'Arabic'];
  static final locales = [
    Locale('en', 'US'),
    Locale('ar', 'UAE'),
  ];
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': enUSA, 'ar_UAE': arUAE};
  void changeLocale(String lang) {
    appGet.lanid.value = lang;
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    appGet.lanid.value = lang;
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
