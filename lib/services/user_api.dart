import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';
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
      final name = UserName(
        title: user['name']['title'],
        first: user['name']['first'],
        last: user['name']['last'],
      );
      return UserModel(
        gender: user['gender'],
        email: user['email'],
        phone: user['phone'],
        cell: user['cell'],
        nat: user['nat'],
        name: name,
      );
    }).toList();
    return users;
  }
}
