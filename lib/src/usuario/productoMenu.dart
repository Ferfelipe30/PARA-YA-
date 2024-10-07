import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

// ignore: camel_case_types
class productoMenu extends StatefulWidget {
  const productoMenu({super.key});

  @override
  State<productoMenu> createState() => productoMenuPage();
}

// ignore: camel_case_types
class productoMenuPage extends State<productoMenu> {
  final buscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const navDrawer(),
      appBar: AppBar(
        title: const Text('Menu Productos'),
        centerTitle: true,
      ),
      body: const Text('Menu de productos'),
    );
  }
}
