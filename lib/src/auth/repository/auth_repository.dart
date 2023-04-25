import 'package:eat/src/auth/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;

  Stream<MyUser?> authStateChanges() {
    return auth.authStateChanges().map((User? user) {
      return user != null
          ? MyUser(
              mobileNumber: user.phoneNumber!,
              uid: user.uid,
              token: user.refreshToken!,
            )
          : null;
    });
  }

  signOut() async {
    await auth.signOut();
  }

  delete() async {
    await auth.currentUser!.delete();
  }
}
