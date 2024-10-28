// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

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
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Text('Menu de Productos'),
                const botonRegistroMenu(),
                StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('productos')
                        .where('userId', isEqualTo: auth.currentUser?.uid)
                        .snapshots(),
                    builder: (context, snackshop) {
                      if (!snackshop.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final productos = snackshop.data!.docs;
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: productos.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(productos[index]['productName']),
                                );
                              },
                            ),
                          ),
                        ],
                      );

                      /*List<Widget> productWidgets = [];
                      for (var producto in productos) {
                        final nombreProducto = producto['nombreProducto'];
                        final descripcionProducto =
                            producto['descripcionProducto'];
                        productWidgets.add(
                          ListTile(
                            title: Text(nombreProducto),
                            subtitle: Text(descripcionProducto),
                          ),
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView(
                              shrinkWrap: true,
                              children: productWidgets,
                            ),
                          ),
                        ],
                      );*/
                    }),
                const buttonGuardarMenu(),
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
