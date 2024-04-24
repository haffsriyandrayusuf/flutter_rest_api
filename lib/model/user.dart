import 'user_dob.dart';
import 'user_id.dart';
import 'user_location.dart';
import 'user_login.dart';
import 'user_name.dart';
import 'user_picture.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserLocation location;
  final UserDob dob;
  final UserId id;
  final UserPicture picture;
  final UserLogin login;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.location,
    required this.dob,
    required this.id,
    required this.picture,
    required this.login,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        cell: json['cell'],
        nat: json['nat'],
        name: UserName.fromJson(json['name']),
        location: UserLocation.fromJson(json['location']),
        dob: UserDob.fromJson(json['dob']),
        id: UserId.fromJson(json['id']),
        picture: UserPicture.fromJson(json['picture']),
        login: UserLogin.fromJson(json['login']),
      );

  String get fullName {
    return "${name.title} ${name.firstName} ${name.lastName}";
  }
}
