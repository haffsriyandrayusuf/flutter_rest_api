import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

class UserAPI {
  Future<List<User>> fetchUser() async {
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final json = jsonDecode(body);
      List result = json['results'];
      return result.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("GAGAL AMBIL DATA");
    }
  }
}
