import 'package:flutter/material.dart';

import '../model/user.dart';
import '../services/user_api.dart';

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
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture.medium),
            ),
            title: Text(user.fullName),
            subtitle: Text(user.location.street.name),
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
