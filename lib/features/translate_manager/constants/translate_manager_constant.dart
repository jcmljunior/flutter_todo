import 'dart:ui';

import '../../../app/constants/app_constant.dart';

class TranslateManagerConstant {
  static const String defaultPathForLocales =
      '${AppConstant.resourcePath}/locales';
  static const Locale defaultLocale = Locale.fromSubtags(
    languageCode: 'pt',
    countryCode: 'BR',
  );
  static const List<Locale> defaultAvailableLocales = [
    Locale.fromSubtags(
      languageCode: 'en',
      countryCode: 'US',
    ),
    Locale.fromSubtags(
      languageCode: 'pt',
      countryCode: 'BR',
    ),
    Locale.fromSubtags(
      languageCode: 'es',
      countryCode: 'ES',
    ),
  ];

  static const Map<String, Map<String, String>> defaultLocalizedStrings = {};
  static const Map<String, bool> defaultIsFullyTranslated = {};
  static const bool defaultIsLoading = false;
  static const String defaultError = '';
}
