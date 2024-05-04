import 'package:flutter/material.dart';

import 'add.dart';
import 'home.dart';
import 'update.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        '/home': (context) => const HomePage(),
        '/add-todo': (context) => const AddPage(),
        '/update-todo': (context) => const UpdatePage(),
      },
      home: const HomePage(),
    );
  }
}
