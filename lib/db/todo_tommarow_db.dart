import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/todo.dart';

class TodoTommarowDbNew{
  TodoTommarowDbNew._init();
  static final TodoTommarowDbNew instance = TodoTommarowDbNew._init();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('todoTommarowNew.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB (Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';


    await db.execute('CREATE TABLE $tableTodoTommarownew (${todoFields.id} $idType,${todoFields.todoItem} $textType,${todoFields.catogary} $textType, ${todoFields.ischecked} $boolType)');
  }

  Future<todo> create(todo Todo) async{
    final db = await instance.database;

    final id = await db.insert(tableTodoTommarownew, Todo.toJson());

    return Todo.copy(id: id);
  }

  Future<todo> readtodo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableTodoTommarownew,
      columns: todoFields.values,
      where: '${todoFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return todo.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }
  }

  Future<List<todo>> readAllTodo() async{
    final db = await instance.database;
    final orderby = '${todoFields.id} ASC';

    final result = await db.query(tableTodoTommarownew, orderBy: orderby);

    return result.map((json) => todo.fromJson(json)).toList();
  }

  Future<int> update(todo Todo) async{
    final db = await instance.database;

    return db.update(
      tableTodoTommarownew,
      Todo.toJson(),
      where: '${todoFields.id} = ?',
      whereArgs: [Todo.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableTodoTommarownew,
      where: '${todoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}