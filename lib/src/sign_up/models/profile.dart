import 'package:eat/src/utils/models/my_location.dart';
import 'package:formz/formz.dart';

class Profile {
  Profile({
    required this.mobileNumberInput,
    required this.dietInput,
    required this.location,
  });

  FormzInput mobileNumberInput;
  FormzInput dietInput;
  MyLocation location;
}
