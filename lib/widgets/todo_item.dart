import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_todo/constants/colors.dart';

import '../models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todoMD;
  final onTodoChange;
  final onDeleteItem;
  const TodoItem({
    super.key,
    required this.todoMD,
    required this.onTodoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onTap: () {
          onTodoChange(todoMD);
        },
        tileColor: Colors.white,
        leading: Icon(
          todoMD.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        title: Text(
          todoMD.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todoMD.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          // padding: EdgeInsets.all(0),
          // margin: EdgeInsets.symmetric(vertical: 0),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todoMD.id);
            },
            color: Colors.white,
            iconSize: 18,
            icon: Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
