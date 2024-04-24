import 'package:flutter/material.dart';

import '../model/user.dart';
import '../services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // UserAPI userapi = UserAPI();
  // late Future<List<User>> futureUser;
  Future<List<User>> userFuture = UserAPI().fetchUser();

  // @override
  // void initState() {
  //   super.initState();
  // futureUser = userapi.fetchUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rest API Call"),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listUser = snapshot.data!;
              return ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = listUser[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    title: Text(user.email),
                    subtitle: Text(user.cell),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
