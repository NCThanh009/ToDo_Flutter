import 'package:flutter/material.dart';
import 'package:flutter_application_todo/constants/colors.dart';
import 'package:flutter_application_todo/widgets/todo_item.dart';

import '../models/todo_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = TodoModel.todoList();
  final _todoController = TextEditingController();
  List<TodoModel> _foundTodoMD = [];

  @override
  void initState() {
    _foundTodoMD = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      appBar: _AppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Tất cả công việc",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (TodoModel todoMD in _foundTodoMD.reversed)
                        TodoItem(
                          todoMD: todoMD,
                          onTodoChange: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: "Thêm công việc mới",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 14, 162, 26),
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// xử lý checkbox
  void _handleTodoChange(TodoModel todoModel) {
    setState(() {
      todoModel.isDone = !todoModel.isDone;
    });
  }

//xóa todo
  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

//thêm Todo
  void _addTodoItem(String add) {
    setState(() {
      todoList.add(
        TodoModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: add),
      );
    });
    _todoController.clear();
  }

//xử lý list khi tim kiếm
  void _runFilter(String key) {
    List<TodoModel> results = [];
    if (key.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where(
            (element) =>
                element.todoText!.toLowerCase().contains(key.toLowerCase()),
          )
          .toList();
    }
    setState(() {
      _foundTodoMD = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 30,
            minWidth: 30,
          ),
          border: InputBorder.none,
          hintText: "Tìm kiếm",
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _AppBar() {
    return AppBar(
      elevation: 2,
      backgroundColor: tdBG,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/person.png"),
            ),
          ),
        ],
      ),
    );
  }
}
