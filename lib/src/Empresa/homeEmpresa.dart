// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/nav.dart';

// ignore: camel_case_types
class homeEmpresa extends StatefulWidget {
  const homeEmpresa({super.key});

  @override
  State<homeEmpresa> createState() => homeEmpresaPage();
}

// ignore: camel_case_types
class homeEmpresaPage extends State<homeEmpresa> {
  final buscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const nav(),
      appBar: AppBar(
        title: TextField(
          controller: buscar,
          decoration: const InputDecoration(
              hintText: 'Buscar', border: InputBorder.none),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
    );
  }
}
