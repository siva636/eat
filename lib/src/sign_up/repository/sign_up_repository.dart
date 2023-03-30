import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat/src/sign_up/models/models.dart';
import 'package:eat/src/utils/enums/location_data.dart';

class SignUpRepository {
  final db = FirebaseFirestore.instance;

  signUp(Profile profile) async {
    final data = {
      'mobileNumber': profile.mobileNumberInput.value,
      'diet': profile.dietInput.value,
      'location': {
        'latitude': profile.location.location?[LocationData.latitude],
        'longitude': profile.location.location?[LocationData.longitude],
      },
    };
    DocumentReference doc = await db.collection("eat").add(data);
    return doc.id;
  }
}
