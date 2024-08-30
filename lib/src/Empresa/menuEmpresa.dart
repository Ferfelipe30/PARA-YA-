// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/homeEmpresa.dart';
import 'package:para_ya/src/Empresa/productoNuevoEmpresa.dart';

// ignore: camel_case_types
class menuEmpresa extends StatefulWidget {
  const menuEmpresa({super.key});

  @override
  State<menuEmpresa> createState() => menuEmpresaPage();
}

// ignore: camel_case_types
class menuEmpresaPage extends State<menuEmpresa> {
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
        child: const Scaffold(
          backgroundColor: Color.fromARGB(197, 255, 255, 255),
          body: Center(
              child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text('Menu de Productos'),
                botonRegistroMenu(),
                buttonGuardarMenu(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class botonRegistroMenu extends StatelessWidget {
  const botonRegistroMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const productoNuevoEmpresa()));
        },
        child: const Text('Agregar producto al menu'));
  }
}

// ignore: camel_case_types
class buttonGuardarMenu extends StatelessWidget {
  const buttonGuardarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const homeEmpresa()));
        },
        child: const Text('Guardar'));
  }
}
