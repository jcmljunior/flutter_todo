import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/features/translate_manager/constants/translate_manager_constant.dart';
import 'package:flutter_todo/features/translate_manager/states/translate_manager_state.dart';
import 'package:flutter_todo/features/translate_manager/stores/translate_manager_store.dart';

import '../../mock_data/mock.data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('currentLocale setter deve atualizar o estado.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Locale locale = Locale('pt', 'BR');

    translateManagerStore.currentLocale = locale;

    expect(translateManagerStore.currentLocale, equals(locale));
  });

  test('localizedStrings setter deve atualizar o estado.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Map<String, Map<String, String>> localizedStrings = {'pt-BR': {}};

    translateManagerStore.localizedStrings = localizedStrings;

    expect(translateManagerStore.localizedStrings, equals(localizedStrings));
  });

  test('isFullyTranslated setter deve atualizar o estado.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Map<String, bool> isFullyTranslated = {'pt-BR': true};

    translateManagerStore.isFullyTranslated = isFullyTranslated;

    expect(translateManagerStore.isFullyTranslated, equals(isFullyTranslated));
  });

  test('isLoading setter deve atualizar o estado.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const bool isLoading = !TranslateManagerConstant.defaultIsLoading;

    translateManagerStore.isLoading = isLoading;

    expect(translateManagerStore.isLoading, equals(isLoading));
  });

  test('error setter deve atualizar o estado.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const String error = 'error';

    translateManagerStore.error = error;

    expect(translateManagerStore.error, equals(error));
  });

  test('loadLocalizedStringsHandler deve retornar as traduções solicitadas.',
      () async {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Locale locale = TranslateManagerConstant.defaultLocale;

    final Map<String, Map<String, String>> localizedStrings =
        await translateManagerStore.loadLocalizedStringsHandler(locale);

    expect(localizedStrings,
        contains(TranslateManagerConstant.defaultLocale.toString()));
    expect(localizedStrings[locale.toString()], isNotEmpty);
  });

  test(
      'loadLocalizedStringsHandler deve retornar o valor inserido previamente como cache.',
      () async {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Locale locale = Locale('pt', 'BR');
    const Map<String, Map<String, String>> localizedStrings = {
      'pt_BR': {'key': 'value'},
    };

    translateManagerStore.localizedStrings = localizedStrings;

    expect(await translateManagerStore.loadLocalizedStringsHandler(locale),
        equals(localizedStrings));
  });

  test(
      'updateLocaleHandler deve atualizar todos os estados com base no locale.',
      () async {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Locale locale = Locale('pt', 'BR');
    const Map<String, Map<String, String>> localizedStrings = {
      'pt_BR': {'key': 'value'},
    };

    translateManagerStore.currentLocale = locale;
    translateManagerStore.localizedStrings = localizedStrings;

    // Força o carregamento das traduções.
    // Deve retornar o valor inserido previamente como cache.
    // Se o force não for utilizado, um novo mapa de traduções será carregado tornando-se incompativel com o mock testado.
    await translateManagerStore.updateLocaleHandler(locale, true);

    expect(translateManagerStore.currentLocale, equals(locale));
    expect(translateManagerStore.localizedStrings, equals(localizedStrings));
  });

  test(
      'getAvailableLocalesOrderBy deve retornar a lista de idiomas ordenado tendo como prioridade o idioma atual.',
      () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());
    const Locale currentLocale = Locale('pt', 'BR');
    const List<Locale> availableLocales = [
      Locale('en', 'US'),
      Locale('es', 'ES'),
      Locale('pt', 'BR')
    ];

    final List<Locale> availableLocalesOrderBy =
        translateManagerStore.getAvailableLocalesOrderBy(currentLocale);

    expect(availableLocalesOrderBy, isNot(equals(availableLocales)));
    expect(availableLocalesOrderBy.first, currentLocale);
  });

  test('fetchLocalizedStrings deve retornar as traduções solicitadas.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());

    translateManagerStore.currentLocale = const Locale('pt', 'BR');
    translateManagerStore.localizedStrings = {
      'pt_BR': {'welcome': 'Bem vindo(a), %s'},
    };

    const String key = 'welcome';
    List<String> replacements = [
      MockData.generateString(),
    ];

    expect(translateManagerStore.fetchLocalizedStrings(key, replacements),
        isNotNull);
    expect(translateManagerStore.fetchLocalizedStrings(key, replacements),
        equals('Bem vindo(a), ${replacements.first}'));
  });

  test('cleanUnusedLocalizedStringsHandler deve limpar os estados.', () {
    final TranslateManagerStore translateManagerStore =
        TranslateManagerStore(const TranslateManagerInitial());

    translateManagerStore.currentLocale = const Locale('pt', 'BR');
    translateManagerStore.localizedStrings = {
      'pt_BR': {'welcome': 'Bem vindo(a), %s'},
      'en_US': {'welcome': 'Welcome, %s'},
      'es_ES': {'welcome': 'Bienvenido(a), %s'},
    };

    // Elimina as traduções que não serão utilizadas.
    // É possível que haja até dois idiomas carregados. O padrão, e o idioma do sistema operacional.
    translateManagerStore.cleanUnusedLocalizedStringsHandler();

    expect(translateManagerStore.localizedStrings.length, isNot(equals(0)));
    expect(translateManagerStore.localizedStrings.length <= 2, isTrue);
  });
}
