import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_todo/features/translate_manager/constants/translate_manager_constant.dart';
import 'package:flutter_todo/features/translate_manager/repositories/translate_manager_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loadLocalizedStrings deve retornar um Map<String, Map<String, String>>',
      () async {
    final TranslateManagerRepository repository =
        TranslateManagerRepositoryImpl();
    final Map<String, Map<String, String>> localizedStrings = await repository
        .loadLocalizedStrings(TranslateManagerConstant.defaultLocale);

    expect(localizedStrings, isNotEmpty);
    expect(localizedStrings[TranslateManagerConstant.defaultLocale.toString()],
        isNotEmpty);
  });
}
