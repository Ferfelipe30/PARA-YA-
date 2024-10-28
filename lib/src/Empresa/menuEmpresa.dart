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
  final firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
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
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text('Menu de Productos'),
                  const botonRegistroMenu(),
                  StreamBuilder(
                      stream: firestore
                          .collection('producto')
                          .where('userID', isEqualTo: user?.email)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final products = snapshot.data!.docs;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ListTile(
                                    title: Text(product['nombreProducto']),
                                    subtitle:
                                        Text(product['descripcionProducto']),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }),
                  const buttonGuardarMenu(),
                ],
              ),
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
