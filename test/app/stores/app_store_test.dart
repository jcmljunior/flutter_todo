import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/app/states/app_state.dart';
import 'package:flutter_todo/app/stores/app_store.dart';

void main() {
  test('isInitialized deve inicializar como falso.', () {
    final appStore = AppStore(const AppInitial());

    expect(appStore.isInitialized, isFalse);
  });

  test('isInitialized setter deve atualizar o estado.', () {
    final appStore = AppStore(const AppInitial());

    appStore.isInitialized = true;

    expect(appStore.isInitialized, isTrue);
  });
}
