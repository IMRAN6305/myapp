import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/todo_provider.dart';

import '../../../data/models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Todos'),
      // ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          if (todoProvider.todoList.isEmpty) {
            return Center(
              child: Text(
                'No Todos added',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: todoProvider.todoList.length,
              itemBuilder: (_, index) {
                TodoModel todo = todoProvider.todoList[index];
                return TodoTile(todo: todo);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddTodoSheet(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  final TodoModel todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      tileColor: todo.isCompleted ? Colors.green : Colors.orange,
      controlAffinity: ListTileControlAffinity.leading,
      value: todo.isCompleted,
      onChanged: (value) {
        // Provider.of<TodoProvider>(context, listen: false)
        //     .toggleCompletion(todo);
      },
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        todo.desc,
        style: TextStyle(
          decoration: todo.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => EditTodoSheet(todo: todo),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .deleteTodo(todo.id);
            },
          ),
        ],
      ),
    );
  }
}

class AddTodoSheet extends StatefulWidget {
  @override
  _AddTodoSheetState createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Todo',
            style: TextStyle(fontSize: 21),
          ),
          SizedBox(height: 16.0),
          TextField(controller: titleController),
          SizedBox(height: 8.0),
          TextField(controller: descController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              TodoModel newTodo = TodoModel(
                title: titleController.text,
                desc: descController.text,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: '', // Leave it empty, Firestore will generate the ID
              );
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(newTodo);
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

class EditTodoSheet extends StatefulWidget {
  final TodoModel todo;

  const EditTodoSheet({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoSheetState createState() => _EditTodoSheetState();
}

class _EditTodoSheetState extends State<EditTodoSheet> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descController = TextEditingController(text: widget.todo.desc);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit Todo',
            style: TextStyle(fontSize: 21),
          ),
          SizedBox(height: 16.0),
          TextField(controller: titleController),
          SizedBox(height: 8.0),
          TextField(controller: descController),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              TodoModel updatedTodo = TodoModel(
                id: widget.todo.id,
                title: titleController.text,
                desc: descController.text,
                createdAt: widget.todo.createdAt,
                isCompleted: widget.todo.isCompleted,
              );
              Provider.of<TodoProvider>(context, listen: false)
                  .updateTodo(updatedTodo);
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
