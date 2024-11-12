import 'package:flutter_todo/features/accounts/models/user.model.dart';

import '../../mock_data/mock.data.dart';

class MockUser {
  static UserModel generateUser({
    int? id,
    String? name,
    String? email,
    String? password,
    int? age,
    String? gender,
    String? biography,
    DateTime? birthDate,
    DateTime? createdAt,
  }) =>
      UserModel(
        id: id ?? MockData.generateInt(),
        name: name ?? MockData.generateString(),
        email: email ?? MockData.generateString(),
        password: password ?? MockData.generateString(),
        age: age ?? MockData.generateInt(),
        gender: gender ?? MockData.generateString(),
        biography: biography ?? MockData.generateString(),
        birthDate: birthDate ??
            DateTime.now().subtract(
                Duration(days: 360 * MockData.generateInt(min: 1, max: 10))),
      );

  static List<UserModel> generateUsers([int length = 10]) =>
      List.generate(length, (index) => generateUser(id: index));
}
