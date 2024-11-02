import 'package:flutter/material.dart' show immutable;

import '../models/user.model.dart';

@immutable
sealed class AccountsState {
  final bool? isLoading;
  final List<UserModel>? accounts;

  const AccountsState({
    this.isLoading,
    this.accounts,
  })  : assert(
          isLoading != null,
          'isLoading cannot be null',
        ),
        assert(
          accounts != null,
          'accounts cannot be null',
        );

  Accounts copyWith({
    bool? isLoading,
    List<UserModel>? accounts,
  });
}

class Accounts extends AccountsState {
  const Accounts({
    bool? isLoading,
    List<UserModel>? accounts,
  }) : super(
          isLoading: isLoading ?? false,
          accounts: accounts ?? const [],
        );

  @override
  Accounts copyWith({
    bool? isLoading,
    List<UserModel>? accounts,
  }) =>
      Accounts(
        isLoading: isLoading ?? this.isLoading,
        accounts: accounts ?? this.accounts,
      );
}
