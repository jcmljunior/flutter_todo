import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../tasks/schemas/task.schema.dart';

class DBHelper {
  dynamic _result;
  String _query = '';
  final List<dynamic> _params = [];

  // Singleton
  static final DBHelper instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() => instance;

  String getQuery() => _query;

  List<dynamic> getParams() => _params;

  dynamic getResult() => _result;

  Future<Database> get database async {
    _database ??= await initDatabase();

    return _database!;
  }

  Future<Database> initDatabase() async {
    final appDocumentsDir = await getApplicationCacheDirectory();
    final String dbPath = p.join(appDocumentsDir.path, "databases", "myDb.db");

    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(TaskSchema.createTable);
        },
      ),
    );
  }

  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }

  DBHelper select([List<String>? columns]) {
    final cols = columns?.join(', ') ?? '*';
    _query = 'SELECT $cols';

    return this;
  }

  DBHelper insert(String table, Map<String, dynamic> values) {
    final cols = values.keys.join(', ');
    final placeholders = values.keys.map((_) => '?').join(', ');
    _query = 'INSERT INTO $table ($cols) VALUES ($placeholders)';
    _params.addAll(values.values);

    return this;
  }

  DBHelper update(String table, Map<String, dynamic> values) {
    final setClause = values.keys.map((key) => '$key = ?').join(', ');
    _query = 'UPDATE $table SET $setClause';
    _params.addAll(values.values);

    return this;
  }

  DBHelper delete(String table) {
    _query = 'DELETE FROM $table';

    return this;
  }

  DBHelper from(String table) {
    _query += ' FROM $table';

    return this;
  }

  DBHelper where(String column, dynamic value, [String operator = '=']) {
    _query += _query.contains('WHERE')
        ? ' AND $column $operator ?'
        : ' WHERE $column $operator ?';
    _params.add(value);

    return this;
  }

  DBHelper orderBy(String column, [bool ascending = true]) {
    _query += ' ORDER BY $column ${ascending ? 'ASC' : 'DESC'}';

    return this;
  }

  DBHelper groupBy(String column) {
    _query += ' GROUP BY $column';

    return this;
  }

  DBHelper limit(int limit) {
    _query += ' LIMIT $limit';

    return this;
  }

  DBHelper offset(int offset) {
    _query += ' OFFSET $offset';

    return this;
  }

  DBHelper join(String table, String onCondition, [String joinType = 'INNER']) {
    _query += ' $joinType JOIN $table ON $onCondition';

    return this;
  }

  DBHelper createTable(String tableName, Map<String, String> columns) {
    final columnDefinitions =
        columns.entries.map((e) => '${e.key} ${e.value}').join(', ');
    _query = 'CREATE TABLE IF NOT EXISTS $tableName ($columnDefinitions)';

    return this;
  }

  DBHelper drop(String table) {
    _query = 'DROP TABLE IF EXISTS $table';

    return this;
  }

  DBHelper likeAndWhere(String column, dynamic value) {
    if (_query.contains('WHERE')) {
      _query += ' AND $column LIKE ?';
    } else {
      _query += ' WHERE $column LIKE ?';
    }
    _params.add("%$value%");

    return this;
  }

  DBHelper likeOrWhere(String column, dynamic value) {
    if (_query.contains('WHERE')) {
      _query += ' OR $column LIKE ?';
    } else {
      _query += ' WHERE $column LIKE ?';
    }
    _params.add("%$value%");

    return this;
  }

  Future<void> execute() async {
    if (_query.isEmpty) {
      return;
    }

    _result = await database.then(
      (Database db) => db.rawQuery(_query, _params).then((result) {
        _query = "";
        _params.clear();

        return result;
      }),
    );
  }
}
