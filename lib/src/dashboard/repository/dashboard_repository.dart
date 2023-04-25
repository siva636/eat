import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardRepository {
  final db = FirebaseFirestore.instance;

  Future deleteProfile(String uid) {
    return db.collection('eat').doc(uid).delete();
  }
}
