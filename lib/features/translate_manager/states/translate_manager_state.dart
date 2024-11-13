import 'package:flutter/material.dart';

import '../constants/translate_manager_constant.dart';

@immutable
sealed class TranslateManagerState {
  final Locale? currentLocale;
  final Map<String, Map<String, String>>? localizedStrings;
  final Map<String, bool>? isFullyTranslated;
  final bool? isLoading;
  final String? error;

  const TranslateManagerState({
    this.currentLocale,
    this.localizedStrings,
    this.isFullyTranslated,
    this.isLoading,
    this.error,
  })  : assert(
          currentLocale != null,
          "currentLocale can't be null",
        ),
        assert(
          localizedStrings != null,
          "localizedStrings can't be null",
        ),
        assert(
          isFullyTranslated != null,
          "isFullyTranslated can't be null",
        ),
        assert(
          isLoading != null,
          "isLoading can't be null",
        ),
        assert(
          error != null,
          "error can't be null",
        );

  TranslateManagerState copyWith({
    Locale? currentLocale,
    Map<String, Map<String, String>>? localizedStrings,
    Map<String, bool>? isFullyTranslated,
    bool? isLoading,
    String? error,
  });
}

class TranslateManagerInitial extends TranslateManagerState {
  const TranslateManagerInitial({
    Locale? currentLocale,
    Map<String, Map<String, String>>? localizedStrings,
    Map<String, bool>? isFullyTranslated,
    bool? isLoading,
    String? error,
  }) : super(
          currentLocale:
              currentLocale ?? TranslateManagerConstant.defaultLocale,
          localizedStrings: localizedStrings ??
              TranslateManagerConstant.defaultLocalizedStrings,
          isFullyTranslated: isFullyTranslated ??
              TranslateManagerConstant.defaultIsFullyTranslated,
          isLoading: isLoading ?? TranslateManagerConstant.defaultIsLoading,
          error: error ?? TranslateManagerConstant.defaultError,
        );

  @override
  TranslateManagerState copyWith(
          {Locale? currentLocale,
          Map<String, Map<String, String>>? localizedStrings,
          Map<String, bool>? isFullyTranslated,
          bool? isLoading,
          String? error}) =>
      TranslateManagerInitial(
        currentLocale: currentLocale ?? this.currentLocale,
        localizedStrings: localizedStrings ?? this.localizedStrings,
        isFullyTranslated: isFullyTranslated ?? this.isFullyTranslated,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}
