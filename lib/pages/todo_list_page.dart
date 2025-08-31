import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todoListItem.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Adicione uma tarefa',
                          hintText: "Ex.: Estudar",
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String textCont = todoController.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: textCont,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //fixedSize: Size(50, 50),
                      ),
                      child: Icon(Icons.add, size: 30, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(todo: todo, onDelete: onDelete),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Você possui ${todos.length} tarefas pendentes",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDeleteConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Limpar tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos = todos.where((item) => item != todo).toList();
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarefa '${todo.title}' removida com sucesso."),
        backgroundColor: Colors.red[400],
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteConfirmationDialog() {
    print("showDeleteConfirmationDialog");
    // setState(() {
    //   todos.clear();
    // });
    showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          title: Text("Limpar tudo?"),
          content: Text("Você tem certeza que deseja apagar todas as tarefas?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  todos.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text("Sim"),
            ),
          ],

        ),
    );
  }
}
