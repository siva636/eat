// TODO: move this to global scope?

import 'package:meta/meta.dart';

@immutable
class NearbyRestaurant {
  const NearbyRestaurant({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.icon,
    required this.vicinity,
  });

  NearbyRestaurant.fromJson(json)
      : this(
          placeId: json['place_id'],
          latitude: json['geometry']['location']['lat'],
          longitude: json['geometry']['location']['lng'],
          name: json['name'],
          icon: json['icon'],
          vicinity: json['vicinity'],
        );

  final String placeId;
  final double latitude;
  final double longitude;
  final String name;
  final String icon;
  final String vicinity;
}
