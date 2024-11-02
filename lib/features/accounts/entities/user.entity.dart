import 'package:flutter/material.dart' show immutable;

@immutable
class UserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final int? age;
  final String? gender;
  final String? biography;
  final DateTime? birthDate;
  final DateTime? createdAt;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.age,
    this.gender,
    this.biography,
    this.birthDate,
    this.createdAt,
  });
}
