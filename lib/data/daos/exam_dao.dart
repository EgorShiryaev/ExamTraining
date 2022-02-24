import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/_models.dart';

class ExamDao {
  static const path = 'exams';
  final CollectionReference collection =
      FirebaseFirestore.instance.collection(path);

  void saveExam(Exam exam) async {
    final list = await collection.get();
    final lastIndex = int.parse(list.docs.last.id);
    collection.doc((lastIndex + 1).toString()).set(exam);
  }

  Stream<QuerySnapshot> getExamStream() {
    return collection.snapshots();
  }

  void deleteExam(String id) {
    collection.doc(id).delete();
  }

  void updateExam(Exam exam) {
    collection.doc(exam.reference!.path).set(exam);
  }
}
