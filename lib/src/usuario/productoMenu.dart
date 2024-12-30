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
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cityfondo.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(197, 255, 255, 255),
          drawer: const navDrawer(),
          appBar: AppBar(
            title: const Text('Menu Productos'),
            centerTitle: true,
          ),
          body: const Text('Menu de productos'),
        ),
      ),
    );
  }
}
