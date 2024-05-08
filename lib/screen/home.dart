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
  bool _isloading = true;

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
      body: _isloading ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture.medium),
            ),
            title: Text(user.fullName),
            subtitle: Text(user.location.coordinates.latitude),
          );
        },
      ),
    );
  }

  void fetchUsers() async {
    final respone = await UserApi.fetchUsers();
    setState(() {
      users = respone;
      _isloading = false;
    });
  }
}
