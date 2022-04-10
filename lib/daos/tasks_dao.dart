import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../settings.dart';

class TasksDao {
  final User user;
  TasksDao({required this.user});

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection(SETTINGS.tasksPath);

  void add(Task task) async {
    task.userId = user.uid;
    final list = await _collection.where('userId', isEqualTo: user.uid).get();
    final lastIndex = list.docs.length;
    _collection.doc('${user.uid}_${lastIndex + 1}').set(task.toJson());
  }

  void delete(String id) => _collection.doc(id).delete();

  get stream => _collection.where('userId', isEqualTo: user.uid).snapshots();

  void update(Task task) {
    _collection.doc(task.reference!.id).set(task.toJson());
  }

  void updateTaskIsCompleted(Task task) {
    _collection.doc(task.reference!.id).update({"completed": task.completed});
  }

  void updateSubtasks(Task task) {
    _collection
        .doc(task.reference!.id)
        .update({"subtasks": task.subtasks.map((e) => e.toJson()).toList()});
  }
}
