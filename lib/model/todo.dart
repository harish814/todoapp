final String tableTodoTodaynew = 'todoTodayNew';
final String tableTodoTommarownew = 'todoTommarowNew';

class todoFields {
  static final List<String> values = [
    id,
    todoItem,
    catogary,
    ischecked,
  ];

  static final String id = '_id';
  static final String todoItem = 'todoItem';
  static final String catogary = 'catogary';
  static final String ischecked = 'false';
}

class todo {
  final int? id;
  final String todoItem;
  final String catogary;
  final bool ischecked;

  const todo(
      {this.id,
      required this.todoItem,
      required this.catogary,
      required this.ischecked});

  todo copy({
    int? id,
    String? todoItem,
    String? catogary,
    bool? ischecked,
  }) =>
      todo(
        id: id ?? this.id,
        todoItem: todoItem ?? this.todoItem,
        catogary: catogary ?? this.catogary,
        ischecked: ischecked ?? this.ischecked,
      );

  static todo fromJson(Map<String, Object?> json) => todo(
    id: json[todoFields.id] as int?,
    todoItem: json[todoFields.todoItem] as String,
    catogary: json[todoFields.catogary] as String,
    ischecked: json[todoFields.ischecked] == 1,
  );

  Map<String, Object?> toJson() => {
        todoFields.id: id,
        todoFields.todoItem: todoItem,
        todoFields.catogary: catogary,
        todoFields.ischecked: ischecked?1:0,
      };
}
