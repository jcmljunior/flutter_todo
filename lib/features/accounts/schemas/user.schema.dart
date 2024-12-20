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
