import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_training/data/daos/_interface_dao.dart';
import 'package:exam_training/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/_models.dart';

class ExamsDao implements InterfaceDao<Exam> {
  final User user;
  ExamsDao({required this.user});

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection(SETTINGS.examsPath);

  @override
  void add(Exam exam) async {
    exam.userId = user.uid;
    final list = await _collection.where('userId', isEqualTo: user.uid).get();
    final lastIndex = list.docs.length;
    _collection.doc('${user.uid}_${lastIndex + 1}').set(exam.toJson());
  }

  @override
  void delete(String id) => _collection.doc(id).delete();

  @override
  get stream => _collection.where('userId', isEqualTo: user.uid).snapshots();

  @override
  void update(Exam exam) =>
      _collection.doc(exam.reference!.id).set(exam.toJson());
}
