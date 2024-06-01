import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamSubscription _subscription;
  List<TodoModel> _listTodo = [];

  TodoProvider() {
    // Initialize the stream subscription
    _subscription = _firestore
        .collection("users")
        .doc(_user!.uid)
        .collection("todo")
        .snapshots()
        .listen((snapshot) {
      _listTodo = snapshot.docs.map((doc) => TodoModel.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  // Getter method to access the list of todos
  List<TodoModel> get todoList => _listTodo;

  @override
  void dispose() {
    // Cancel the stream subscription when the provider is disposed
    _subscription.cancel();
    super.dispose();
  }

  // Method to add a todo to Firestore
  Future<void> addTodo(TodoModel todo) async {
    if (_user != null) {
      try {
        DocumentReference documentReference = await _firestore
            .collection("users")
            .doc(_user!.uid)
            .collection("todo")
            .add({
          'title': todo.title,
          'desc': todo.desc,
          'isCompleted': todo.isCompleted,
          'createdAt': todo.createdAt,
        });

        // Get the ID of the added document
        String documentId = documentReference.id;

        // Update the document with the retrieved ID
        await documentReference.update({'id': documentId});
      } catch (e) {
        print('Error adding todo: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }


  // Method to update a todo in Firestore
  Future<void> updateTodo(TodoModel todo) async {
    if (_user != null) {
      try {
        await _firestore
            .collection("users")
            .doc(_user!.uid)
            .collection("todo")
            .doc(todo.id)
            .update({
          'title': todo.title,
          'desc': todo.desc,
          'isCompleted': todo.isCompleted,
        });
      } catch (e) {
        print('Error updating todo: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  // Method to delete a todo from Firestore
  Future<void> deleteTodo(String todoId) async {
    if (_user != null) {
      try {
        await _firestore
            .collection("users")
            .doc(_user!.uid)
            .collection("todo")
            .doc(todoId)
            .delete();
      } catch (e) {
        print('Error deleting todo: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }
}
