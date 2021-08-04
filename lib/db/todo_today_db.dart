import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/model/todo.dart';

class TodoTodayDbNew{
  TodoTodayDbNew._init();
  static final TodoTodayDbNew instance = TodoTodayDbNew._init();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB('todoTodayNew.db');
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


    await db.execute('CREATE TABLE $tableTodoTodaynew (${todoFields.id} $idType,${todoFields.todoItem} $textType,${todoFields.catogary} $textType, ${todoFields.ischecked} $boolType)');
  }

  Future<todo> create(todo Todo) async{
    final db = await instance.database;

    final id = await db.insert(tableTodoTodaynew, Todo.toJson());

    return Todo.copy(id: id);
  }

  Future<todo> readtodo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableTodoTodaynew,
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

    final result = await db.query(tableTodoTodaynew, orderBy: orderby);
    
    return result.map((json) => todo.fromJson(json)).toList();
  }

  Future<int> update(todo Todo) async{
    final db = await instance.database;

    return db.update(
      tableTodoTodaynew,
      Todo.toJson(),
      where: '${todoFields.id} = ?',
      whereArgs: [Todo.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableTodoTodaynew,
      where: '${todoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}