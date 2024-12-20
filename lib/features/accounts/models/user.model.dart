import '../entities/user.entity.dart';
import '../schemas/user.schema.dart';

class UserModel extends UserEntity {
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
