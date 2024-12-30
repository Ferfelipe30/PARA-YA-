import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

// ignore: camel_case_types
class envio extends StatefulWidget {
  const envio({super.key});

  @override
  State<envio> createState() => envioPage();
}

// ignore: camel_case_types
class envioPage extends State<envio> {
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
          drawer: const navDrawer(),
          appBar: AppBar(
            title: const Text('Envio'),
            centerTitle: true,
          ),
          body: const Text('Envio'),
        ),
      ),
    );
  }
}
