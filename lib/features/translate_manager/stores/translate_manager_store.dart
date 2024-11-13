import 'package:flutter/material.dart';

import '../../value_notifier/extensions/value_notifier_extension.dart';
import '../constants/translate_manager_constant.dart';
import '../repositories/translate_manager_repository.dart';
import '../states/translate_manager_state.dart';

class TranslateManagerStore extends ValueNotifier<TranslateManagerState> {
  final TranslateManagerRepository _translateManagerRepository =
      TranslateManagerRepositoryImpl();

  TranslateManagerStore(super._value) {
    // Força a inicialização do carregamento das traduções.
    updateLocaleHandler(TranslateManagerConstant.defaultLocale, true);
  }

  Locale get currentLocale => state.currentLocale!;

  set currentLocale(Locale value) {
    if (currentLocale == value) return;

    state = state.copyWith(
      currentLocale: value,
    );
  }

  Map<String, Map<String, String>> get localizedStrings =>
      state.localizedStrings!;

  set localizedStrings(Map<String, Map<String, String>> value) {
    if (localizedStrings == value) return;

    state = state.copyWith(
      localizedStrings: value,
    );
  }

  Map<String, bool> get isFullyTranslated => state.isFullyTranslated!;

  set isFullyTranslated(Map<String, bool> value) {
    if (isFullyTranslated == value) return;

    state = state.copyWith(
      isFullyTranslated: value,
    );
  }

  bool get isLoading => state.isLoading!;

  set isLoading(bool value) {
    if (isLoading == value) return;

    state = state.copyWith(
      isLoading: value,
    );
  }

  String get error => state.error!;

  set error(String value) {
    if (error == value) return;

    state = state.copyWith(
      error: value,
    );
  }

  Future<Map<String, Map<String, String>>> loadLocalizedStringsHandler(
      Locale locale) async {
    if (!localizedStrings.containsKey(locale.toString())) {
      return await _translateManagerRepository.loadLocalizedStrings(locale);
    }

    return localizedStrings;
  }

  Future<void> updateLocaleHandler(Locale locale, [bool force = false]) async {
    // Impede que o idioma seja alterado durante o carregamento das traduções.
    // Evita a reconstrução da tela em caso de multiplos toques...
    if (isLoading && !force) return;

    // Impede que o idioma seja alterado sem haver nacessidade.
    if (currentLocale == locale && !force) return;

    isLoading = true;

    try {
      final Map<String, Map<String, String>> newLocalizedStrings =
          await loadLocalizedStringsHandler(locale);

      isFullyTranslated = {
        ...isFullyTranslated,
        locale.toString(): localizedStrings.containsKey(locale.toString())
            ? localizedStrings[
                        TranslateManagerConstant.defaultLocale.toString()]!
                    .length ==
                newLocalizedStrings[locale.toString()]!.length
            : force,
      };

      localizedStrings = {
        ...localizedStrings,
        locale.toString(): newLocalizedStrings[locale.toString()] ?? {},
      };
    } finally {
      currentLocale = locale;
      isLoading = false;
    }
  }

  List<Locale> getAvailableLocalesOrderBy(Locale value) {
    final List<Locale> availableLocales =
        TranslateManagerConstant.defaultAvailableLocales.toList();

    if (!availableLocales.contains(value)) {
      return availableLocales;
    }

    availableLocales.removeWhere((currentLocale) => currentLocale == value);
    availableLocales.insert(0, value);

    return availableLocales;
  }

  String fetchLocalizedStrings(String key, [List<String>? replacements]) {
    String message = localizedStrings[currentLocale.toString()]?[key] ?? key;

    if (replacements != null) {
      for (final String word in replacements) {
        message = message.replaceFirst(
          RegExp(r'%s'),
          word,
        );
      }
    }

    return message;
  }

  void cleanUnusedLocalizedStringsHandler() {
    localizedStrings.removeWhere((key, _) =>
        key != currentLocale.toString() &&
        key != TranslateManagerConstant.defaultLocale.toString());
  }
}
