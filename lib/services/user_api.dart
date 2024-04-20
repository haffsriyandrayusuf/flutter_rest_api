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
      final name = UserName(
        title: user['name']['title'],
        first: user['name']['first'],
        last: user['name']['last'],
      );
      final coordinates = LocationCoordinate(
        latitude: user['location']['coordinates']['latitude'],
        longitude: user['location']['coordinates']['longitude'],
      );
      final street = LocationStreet(
        number: user['location']['street']['number'],
        name: user['location']['street']['name'],
      );
      final timezone = LocationTimezone(
        offset: user['location']['timezone']['offset'],
        description: user['location']['timezone']['description'],
      );
      final location = UserLocation(
        city: user['location']['city'],
        state: user['location']['state'],
        country: user['location']['country'],
        postcode: user['location']['postcode'].toString(),
        street: street,
        coordinates: coordinates,
        timezone: timezone,
      );
      final date = user['dob']['date'];
      final dob = UserDob(
        age: user['dob']['age'],
        date: DateTime.parse(date),
      );
      final picture = UserPicture(
        large: user['picture']['large'],
        medium: user['picture']['medium'],
        thumbnail: user['picture']['thumbnail'],
      );
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
