// TODO: move this to global scope?

import 'package:eat/src/utils/enums/diet.dart';
import 'package:eat/src/utils/enums/location_data.dart';
import 'package:eat/src/utils/models/my_location.dart';

class ProfileForSearch {
  ProfileForSearch({
    required this.uid,
    required this.diet,
    required this.location,
  });
  factory ProfileForSearch.fromJson(json) {
    return ProfileForSearch(
      uid: json['uid'],
      diet: json['diet'] == 'v' ? Diet.vegetarian : Diet.nonvegetarian,
      location: MyLocation.allowed(
        {
          LocationData.latitude: json['location']['latitude'],
          LocationData.longitude: json['location']['longitude'],
        },
      ),
    );
  }

  final String uid;
  final Diet diet;
  final MyLocation location;
}
