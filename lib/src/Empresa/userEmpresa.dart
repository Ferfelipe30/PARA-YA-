// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/nav.dart';

// ignore: camel_case_types
class userEmpresa extends StatefulWidget {
  const userEmpresa({super.key});

  @override
  State<userEmpresa> createState() => userEmpresaPage();
}

// ignore: camel_case_types
class userEmpresaPage extends State<userEmpresa> {
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
            title: const Text('Usuario'),
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
