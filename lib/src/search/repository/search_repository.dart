import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat/src/search/models/models.dart';
import 'package:eat/src/search/repository/test_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String key = dotenv.env['key']!;

class SearchRepository {
  getNearbyRestaurants() {}

  Future<ProfileForSearch> fetchProfile(String uid) async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection("eat").doc(uid).get();
    return ProfileForSearch.fromJson(snapshot.data());
  }

  Future<List<NearbyRestaurant>> getNearbyRestaurantsForTest() {
    final List<dynamic> results = testData['results'] as List<dynamic>;
    final List<NearbyRestaurant> processedResults = results
        .map(
          (e) => NearbyRestaurant.fromJson(e),
        )
        .toList();
    return Future.delayed(
      const Duration(seconds: 3),
      () => Future.value(processedResults),
    );
  }
}
