import 'package:equatable/equatable.dart';

import '../entities/user.entity.dart';

class UserSchema {
  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
  static const age = 'age';
  static const gender = 'gender';
  static const biography = 'biography';
  static const birthDate = 'birth_date';
  static const createdAt = 'created_at';
  static const tableName = 'users';
  static const columns = [
    id,
    name,
    email,
    password,
    age,
    gender,
    biography,
    birthDate,
    createdAt
  ];
  static const values = {
    id: 'INTEGER PRIMARY KEY AUTOINCREMENT',
    name: 'TEXT NOT NULL',
    email: 'TEXT NOT NULL',
    password: 'TEXT NOT NULL',
    age: 'INTEGER NOT NULL',
    gender: 'INTEGER NOT NULL',
    biography: 'TEXT NOT NULL',
    birthDate: 'TEXT NOT NULL',
    createdAt: 'DATETIME NOT NULL',
  };

  static final createTable =
      '''CREATE TABLE IF NOT EXISTS $tableName (${values.entries.map((e) => '${e.key} ${e.value}').join(', ')})''';
}

class UserModel extends UserEntity with EquatableMixin {
  const UserModel({
    super.id,
    super.name,
    super.email,
    super.password,
    super.age,
    super.gender,
    super.biography,
    super.birthDate,
    super.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        age,
        gender,
        biography,
        birthDate,
        createdAt,
      ];

  UserModel copyWith({
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
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        biography: biography ?? this.biography,
        birthDate: birthDate ?? this.birthDate,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json[UserSchema.id],
        name: json[UserSchema.name],
        email: json[UserSchema.email],
        password: json[UserSchema.password],
        age: json[UserSchema.age],
        gender: json[UserSchema.gender],
        biography: json[UserSchema.biography],
        birthDate: DateTime.parse(json[UserSchema.birthDate]),
        createdAt: DateTime.parse(json[UserSchema.createdAt]),
      );

  Map<String, dynamic> toJson() => {
        UserSchema.id: id,
        UserSchema.name: name,
        UserSchema.email: email,
        UserSchema.password: password,
        UserSchema.age: age,
        UserSchema.gender: gender,
        UserSchema.biography: biography,
        UserSchema.birthDate: birthDate,
        UserSchema.createdAt: createdAt,
      };
}
