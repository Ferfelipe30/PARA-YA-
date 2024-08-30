import 'package:flutter/material.dart';
import 'package:para_ya/src/navDrawer.dart';

// ignore: camel_case_types
class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => userPage();
}

// ignore: camel_case_types
class userPage extends State<user> {
  final buscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const navDrawer(),
      appBar: AppBar(
        title: const Text('Usuario'),
        centerTitle: true,
      ),
      body: const Text('Usuario'),
    );
  }
}
