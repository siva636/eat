import 'package:cloud_firestore/cloud_firestore.dart';

class SignInRepository {
  final db = FirebaseFirestore.instance;

  Future<bool> isSignedUp(String mobileNUmber) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("eat")
          .where("mobileNumber", isEqualTo: mobileNUmber)
          .get();

      int n = querySnapshot.docs.length;

      return n > 0;
    } catch (e) {
      return Future.error(Exception('Network error'));
    }
  }
}
