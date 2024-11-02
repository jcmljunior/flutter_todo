import 'package:flutter_todo/features/accounts/models/user.model.dart';
import 'package:flutter_todo/features/accounts/stores/account.store.dart';
import 'package:test/test.dart';

void main() {
  final user1 = UserModel(
    id: 0,
    name: 'Amanda',
    email: 'amanda@gmail.com',
    password: '123',
    age: 24,
    gender: 'Female',
    biography: 'I am a developer',
    birthDate: DateTime.now().subtract(const Duration(days: 360 * 29)),
    createdAt: DateTime.now(),
  );
  final user2 = UserModel(
    id: 1,
    name: 'Ana Clara',
    email: 'anaclara@gmailcom',
    password: '123',
    age: 18,
    gender: 'Female',
    biography: 'I am a developer',
    birthDate: DateTime.now().subtract(const Duration(days: 360 * 24)),
    createdAt: DateTime.now(),
  );

  group('Inicio do teste: AccountStore', () {
    test('Método: addUser', () {
      final accountStore = AccountStore();

      accountStore.addUser(user1);

      expect(accountStore.accounts.contains(user1), true);
    });

    test('Método: addUsers', () {
      final accountStore = AccountStore();

      accountStore.addUsers([user1, user2]);

      expect(accountStore.accounts.contains(user1), true);
      expect(accountStore.accounts.contains(user2), true);
    });

    test('Método: removeUser', () {
      final accountStore = AccountStore();

      accountStore.addUser(user1);
      accountStore.removeUser(user1);

      expect(accountStore.accounts.contains(user1), false);
    });

    test('Método: removeUsers', () {
      final accountStore = AccountStore();

      accountStore.addUsers([user1, user2]);
      accountStore.removeUsers([user1, user2]);

      expect(accountStore.accounts.contains(user1), false);
      expect(accountStore.accounts.contains(user2), false);
    });
  });
}
