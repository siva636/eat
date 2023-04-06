import 'package:meta/meta.dart';

@immutable
class MyUser {
  const MyUser({
    required this.mobileNumber,
    required this.uid,
    required this.token,
  });
  final String mobileNumber;
  final String uid;
  final String token;
}
