import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';

import 'components.dart';

class CircleCategory extends StatelessWidget {
  const CircleCategory({
    Key? key,
    required this.item,
  }) : super(key: key);

  final todo item;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 30,
      backgroundColor: Color(0xff90a4ae),
      child: Center(
        child: Text(
          item.catogary,
          style: category,
          softWrap: true,
        ),
      ),
    );
  }
}

class TextTodo extends StatelessWidget {
  const TextTodo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final todo item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.todoItem,
      style: TextStyle(
          fontSize: 22,
          fontFamily: 'Babas',
          color: item.ischecked
              ? Colors.grey
              : Colors.white,
          fontWeight: FontWeight.bold,
          decoration: item.ischecked
              ? TextDecoration.lineThrough
              : TextDecoration.none),
    );
  }
}