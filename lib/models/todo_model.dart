class TodoModel {
  String? id;
  String? todoText;
  late bool isDone;

  TodoModel({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<TodoModel> todoList() {
    return [
      TodoModel(
        id: "001",
        todoText: "Check mail",
        isDone: true,
      ),
      TodoModel(
        id: "002",
        todoText: "Check mail",
        isDone: true,
      ),
      TodoModel(
        id: "003",
        todoText: "Check mail",
      ),
      TodoModel(
        id: "004",
        todoText: "Check mail",
        isDone: true,
      ),
      TodoModel(
        id: "005",
        todoText: "Check mail",
      ),
    ];
  }
}
