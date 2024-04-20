import 'user_dob.dart';
import 'user_location.dart';
import 'user_name.dart';
import 'user_picture.dart';

class UserModel {
  final String gender;
  final UserName name;
  final UserLocation location;
  final String email;
  final UserDob dob;
  final String phone;
  final String cell;
  final UserPicture picture;
  final String nat;

  UserModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.phone,
    required this.cell,
    required this.picture,
    required this.nat,
  });

  String get fullName {
    return "${name.title} ${name.first} ${name.last}";
  }
}
