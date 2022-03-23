import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/data/daos/_interface_dao.dart';
import 'package:exam_training/settings.dart';

import '../models/_models.dart';

class ExamsDao implements InterfaceDao<Exam> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection(SETTINGS.examsPath);

  @override
  void add(Exam exam) async {
    final list = await _collection.get();
    if (list.docs.isEmpty) {
      _collection.doc('0').set(exam.toJson());
    } else {
      final lastIndex = int.parse(list.docs.last.id);
      _collection.doc((lastIndex + 1).toString()).set(exam.toJson());
    }
  }

  @override
  void delete(String id) => _collection.doc(id).delete();

  @override
  get stream => _collection.snapshots();

  @override
  void update(Exam exam) =>
      _collection.doc(exam.reference!.id).set(exam.toJson());
}
