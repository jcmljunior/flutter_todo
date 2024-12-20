class TaskSchema {
  static const id = 'id';
  static const authorId = 'author_id';
  static const title = 'title';
  static const content = 'content';
  static const isFavorite = 'is_favorite';
  static const isCompleted = 'is_completed';
  static const createdAt = 'created_at';
  static const tableName = 'tasks';
  static const columns = [
    id,
    authorId,
    title,
    content,
    isFavorite,
    isCompleted,
    createdAt,
  ];
  static const values = {
    id: 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE',
    authorId: 'INTEGER NOT NULL',
    title: 'TEXT NOT NULL',
    content: 'TEXT NOT NULL',
    isFavorite: 'INTEGER NOT NULL',
    isCompleted: 'INTEGER NOT NULL',
    createdAt: 'DATETIME NOT NULL',
  };
  static final createTable =
      '''CREATE TABLE IF NOT EXISTS $tableName (${values.entries.map((e) => '${e.key} ${e.value}').join(', ')})''';
}
