import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/features/accounts/models/user.model.dart';
import 'package:flutter_todo/features/accounts/stores/account.store.dart';
import '../mocks/mock_user.dart';

void main() {
  final List<UserModel> users = MockUser.generateUsers();

  test('AccountStore deve iniciar com lista de contas vazia', () {
    final accountStore = AccountStore();
    expect(accountStore.accounts, isEmpty,
        reason: 'A lista de contas deve estar vazia');
  });

  test('addUser deve adicionar um usuário à lista de contas', () {
    final accountStore = AccountStore();

    accountStore.addUser(users.first);

    expect(accountStore.accounts, contains(users.first),
        reason: 'A lista de contas deve conter [users.first]');
    expect(accountStore.accounts.length, equals(1),
        reason: 'O tamanho da lista deve ser 1');
  });

  test('removeUser deve remover um usuário da lista de contas', () {
    final accountStore = AccountStore();

    accountStore.addUser(users.first);
    accountStore.removeUser(users.first);

    expect(accountStore.accounts, isNot(contains(users.first)),
        reason: 'A lista de contas não deve conter [users.first]');
    expect(accountStore.accounts.length, equals(0),
        reason: 'O tamanho da lista deve ser 0');
  });

  test('users setter deve atualizar a lista completa de contas', () {
    final accountStore = AccountStore();

    accountStore.users = [users.elementAt(0), users.elementAt(1)];

    expect(accountStore.accounts,
        containsAll([users.elementAt(0), users.elementAt(1)]),
        reason:
            'A lista de contas deve conter [users.elementAt(0), users.elementAt(1)]');
    expect(accountStore.accounts.length, equals(2),
        reason: 'O tamanho da lista deve ser 2');
  });
}
