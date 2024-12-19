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
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cityfondo.webp'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(197, 255, 255, 255),
          drawer: const nav(),
          appBar: AppBar(
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: buscar,
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  suffixIcon: buscar.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            buscar.clear();
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
