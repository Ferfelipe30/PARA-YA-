// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/nav.dart';
import 'package:para_ya/src/Empresa/productoNew.dart';

// ignore: camel_case_types
class productosMenu extends StatefulWidget {
  const productosMenu({super.key});

  @override
  State<productosMenu> createState() => productosMenuPage();
}

// ignore: camel_case_types
class productosMenuPage extends State<productosMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const nav(),
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
      ),
      body: const Text('Menu'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const productoNew()));
        },
        child: const Icon(Icons.restaurant),
      ),
    );
  }
}
