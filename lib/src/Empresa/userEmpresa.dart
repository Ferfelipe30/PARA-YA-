// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

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
          body: StreamBuilder<DocumentSnapshot>(
            stream: firestore.collection('empresas').doc(user?.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                  child: Text('No hay datos disponibles.'),
                );
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.business),
                        title: const Text('Nombre'),
                        subtitle: Text(data['nombreEmpresa']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(data['emailEmpresa']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.category),
                        title: const Text('Tipo de Empresa'),
                        subtitle: Text(data['tipoEmpresa']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.flag),
                        title: const Text('País'),
                        subtitle: Text(data['pais']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_city),
                        title: const Text('Departamento'),
                        subtitle: Text(data['departamento']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text('Ciudad'),
                        subtitle: Text(data['ciudad']),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Dirección'),
                        subtitle: Text(data['direccion']),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
