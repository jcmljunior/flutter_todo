import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/translate_manager_constant.dart';

@immutable
abstract class TranslateManagerRepository {
  Future<Map<String, Map<String, String>>> loadLocalizedStrings(Locale locale,
      {Map<String, Map<String, String>> fallback =
          TranslateManagerConstant.defaultLocalizedStrings});
}

class TranslateManagerRepositoryImpl implements TranslateManagerRepository {
  @override
  Future<Map<String, Map<String, String>>> loadLocalizedStrings(
    Locale locale, {
    Map<String, Map<String, String>> fallback =
        TranslateManagerConstant.defaultLocalizedStrings,
  }) async {
    try {
      final Map<String, dynamic> response = jsonDecode(
        await rootBundle.loadString(
          '${TranslateManagerConstant.defaultPathForLocales}/${locale.toString()}.json',
        ),
      );

      return {
        locale.toString(): Map<String, String>.from(response),
      };
    } catch (error, stackTrace) {
      log('${TranslateManagerConstant.defaultPathForLocales}/${locale.toString()}.json');
      log(error.toString(), stackTrace: stackTrace);

      return fallback;
    }
  }
}
