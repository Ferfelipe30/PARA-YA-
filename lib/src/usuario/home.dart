// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homePage();
}

// ignore: camel_case_types
class homePage extends State<home> {
  final buscar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const navDrawer(),
      appBar: AppBar(
        title: TextField(
          controller: buscar,
          decoration: const InputDecoration(
              hintText: 'Buscar', border: InputBorder.none),
        ),
      ),
    );
  }
}
