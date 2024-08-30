import 'package:flutter/material.dart';
import 'package:para_ya/src/navDrawer.dart';

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
    return Scaffold(
      drawer: const navDrawer(),
      appBar: AppBar(
        title: const Text('Envio'),
        centerTitle: true,
      ),
      body: const Text('Envio'),
    );
  }
}
