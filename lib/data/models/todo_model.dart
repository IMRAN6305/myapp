import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String title;
  String desc;
  bool isCompleted;
  int createdAt;

  TodoModel({
    required this.title,
    required this.desc,
    this.isCompleted = false,
    required this.createdAt,
    required this.id
  });

  // Factory constructor to create a TodoModel from Firestore document
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: data['id'],
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: data['createdAt'] ?? 0,
    );
  }
}
