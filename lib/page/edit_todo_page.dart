import 'package:flutter/material.dart';
import 'package:notes/model/todo.dart';
import 'package:notes/provider/todos.dart';
import 'package:notes/widget/todo_form_widget.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String desctiption;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    desctiption = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            IconButton(
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: desctiption,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (desctiption) =>
                  setState(() => this.desctiption = desctiption),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isVaild = _formKey.currentState!.validate();
    if (!isVaild) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, desctiption);
      Navigator.of(context).pop();
    }
  }
}
