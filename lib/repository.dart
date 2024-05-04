import 'dart:convert';

import 'package:flutter_rest_api/models.dart';
import 'package:http/http.dart' as http;

class Repository {
  final url = "https://6635b332415f4e1a5e252945.mockapi.io/todo";

  Future getData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      List<Todo> todo = json.map((e) => Todo.fromJson(e)).toList();
      return todo;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future postData(String title, String desc) async {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'title': title,
        'desc': desc,
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future putData(int id, String title, String desc) async {
    final response = await http.put(
      Uri.parse('$url/$id'),
      body: {
        'title': title,
        'desc': desc,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future deleteData(String id) async {
    final response = await http.delete(
      Uri.parse('$url/$id'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
