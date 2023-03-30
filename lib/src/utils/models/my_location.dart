import 'package:eat/src/utils/enums/location_data.dart';
import 'package:meta/meta.dart';

@immutable
class MyLocation {
  const MyLocation._({this.error, this.location});
  const MyLocation.unknown() : this._();
  const MyLocation.allowed(Map<LocationData, double> location)
      : this._(location: location);
  const MyLocation.denied(String error) : this._(error: error);

  final String? error;
  final Map<LocationData, double>? location;

  bool get isUnknown => error == null && location == null;
  bool get isAllowed => error == null && location != null;
  bool get isDenied => error != null && location == null;
}
