import 'dart:convert';

import 'package:flutter_rest_api/model/user_picture.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../model/user_dob.dart';
import '../model/user_location.dart';
import '../model/user_name.dart';

class UserApi {
  static Future<List<UserModel>> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((user) {
      final name = UserName.fromMap(user['name']);
      final location = UserLocation.fromMap(user['location']);
      final dob = UserDob.fromMap(user['dob']);
      final picture = UserPicture.fromMap(user['picture']);
      return UserModel(
        gender: user['gender'],
        name: name,
        location: location,
        email: user['email'],
        dob: dob,
        phone: user['phone'],
        cell: user['cell'],
        picture: picture,
        nat: user['nat'],
      );
    }).toList();
    return users;
  }
}
