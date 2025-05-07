import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

// ignore: camel_case_types
class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => userPage();
}

// ignore: camel_case_types
class userPage extends State<user> {
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
          drawer: const navDrawer(),
          appBar: AppBar(
            title: const Text('Usuario'),
            centerTitle: true,
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream: firestore.collection('usuario').doc(user?.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                // Si no hay datos en firestore, mostrar datos basicos del usuario autenticado.
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                              )
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Nombre: '),
                          subtitle:
                              Text(user?.displayName ?? 'Nombre no disponible'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email: '),
                          subtitle: Text(user?.email ?? 'Email no disponible'),
                        ),
                      ),
                    ],
                  ),
                );
              }

              //Si hay datos en Firestore, mostrarlos
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: data['profileImageUrl'] != null &&
                              data['profileImageUrl'].isNotEmpty
                          ? NetworkImage(data['profileImageUrl'])
                          : null,
                      child: (data['profileImageUrl'] == null ||
                              data['profileImageUrl'].isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 50,
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Nombre'),
                        subtitle: Text(
                            data['nombreUsuario'] ?? 'Nombre no disponible'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Email'),
                        subtitle:
                            Text(data['emailUsuario'] ?? 'Email no disponible'),
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
