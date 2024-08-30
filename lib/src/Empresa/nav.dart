import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/homeEmpresa.dart';
import 'package:para_ya/src/Empresa/productosMenu.dart';
import 'package:para_ya/src/Empresa/userEmpresa.dart';

// ignore: camel_case_types
class nav extends StatefulWidget {
  const nav({super.key});

  @override
  State<nav> createState() => navPage();
}

// ignore: camel_case_types
class navPage extends State<nav> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const homeEmpresa()));
            },
          ),
          ListTile(
            title: const Text('Productos'),
            leading: const Icon(Icons.restaurant),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const productosMenu()));
            },
          ),
          ListTile(
            title: const Text('User'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const userEmpresa()));
            },
          ),
        ],
      ),
    );
  }
}
