// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/envio.dart';
import 'package:para_ya/src/usuario/home.dart';
import 'package:para_ya/src/usuario/productoMenu.dart';
import 'package:para_ya/src/usuario/user.dart';

// ignore: camel_case_types
class navDrawer extends StatefulWidget {
  const navDrawer({super.key});

  @override
  State<navDrawer> createState() => navDrawerPage();
}

// ignore: camel_case_types
class navDrawerPage extends State<navDrawer> {
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
                  MaterialPageRoute(builder: (context) => const home()));
            },
          ),
          ListTile(
            title: const Text('Productos'),
            leading: const Icon(Icons.shopping_bag),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const productoMenu()));
            },
          ),
          ListTile(
            title: const Text('Pedidos'),
            leading: const Icon(Icons.shopping_cart_sharp),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const envio()));
            },
          ),
          ListTile(
            title: const Text('User'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const user()));
            },
          ),
        ],
      ),
    );
  }
}
