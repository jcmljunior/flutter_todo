import 'package:flutter/foundation.dart';

import '../../value_notifier/extensions/value_notifier.extension.dart';
import '../models/user.model.dart';
import '../states/account.state.dart';

class AccountStore extends ValueNotifier<AccountsState> {
  AccountStore() : super(const Accounts());

  List<UserModel> get accounts => state.accounts!;

  set users(List<UserModel> value) {
    if (accounts == value) return;

    state = state.copyWith(
      accounts: value,
    );
  }

  void addUser(UserModel user) {
    state = state.copyWith(
      accounts: [
        ...accounts,
        user,
      ],
    );
  }

  void addUsers(List<UserModel> users) {
    state = state.copyWith(
      accounts: [
        ...accounts,
        ...users,
      ],
    );
  }

  void removeUser(UserModel user) {
    state = state.copyWith(
      accounts: [
        ...accounts.where((element) => element.id != user.id),
      ],
    );
  }

  void removeUsers(List<UserModel> users) {
    state = state.copyWith(
      accounts: [
        ...accounts.where((element) => !users.contains(element)),
      ],
    );
  }
}
