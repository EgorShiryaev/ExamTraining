import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/data/daos/_interface_dao.dart';
import 'package:exam_training/data/models/task.dart';

import '../../settings.dart';

class TasksDao implements InterfaceDao<Task> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection(SETTINGS.tasksPath);

  @override
  void add(Task task) async {
    final list = await _collection.get();
    if (list.docs.isEmpty) {
      _collection.doc('0').set(task.toJson());
    } else {
      final lastIndex = int.parse(list.docs.last.id);
      _collection.doc((lastIndex + 1).toString()).set(task.toJson());
    }
  }

  @override
  void delete(String id) => _collection.doc(id).delete();

  @override
  get stream => _collection.snapshots();

  @override
  void update(Task task) {
    log(task.reference.toString());
    _collection.doc(task.reference!.id).set(task.toJson());
  }
}
