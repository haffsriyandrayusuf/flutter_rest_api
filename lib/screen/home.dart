import 'package:flutter/material.dart';
import 'package:flutter_rest_api/services/user_api.dart';

import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return ListTile(
            title: Text(user.fullName),
            subtitle: Text(user.phone),
          );
        },
      ),
    );
  }

  void fetchUsers() async {
    final respopne = await UserApi.fetchUsers();
    setState(() {
      users = respopne;
    });
  }
}
