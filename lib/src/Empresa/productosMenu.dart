// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/nav.dart';
import 'package:para_ya/src/Empresa/productoDetalle.dart';
import 'package:para_ya/src/Empresa/productoNew.dart';

// ignore: camel_case_types
class productosMenu extends StatefulWidget {
  const productosMenu({super.key});

  @override
  State<productosMenu> createState() => productosMenuPage();
}

// ignore: camel_case_types
class productosMenuPage extends State<productosMenu> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cityfondo.webp'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          drawer: const nav(),
          appBar: AppBar(
            title: const Text('Productos'),
            centerTitle: true,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('producto')
                .where('userID', isEqualTo: user?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Card(
                    child: ListTile(
                      leading: (document.data() as Map<String, dynamic>)
                                  .containsKey('imageUrl') &&
                              document['imageUrl'] != null
                          ? Image.network(document['imageUrl'])
                          : const Icon(Icons.image),
                      title: Text(document['nombreProducto']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(document['descripcionProducto']),
                          Text(
                            (document.data() != null &&
                                    (document.data() as Map<String, dynamic>)
                                        .containsKey('precioProducto'))
                                ? '\$${document['precioProducto']}'
                                : 'Sin precio',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      onTap: () {
                        final producto =
                            document.data() as Map<String, dynamic>;
                        producto['id'] = document.id;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductoDetalle(
                              producto: producto,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const productoNew()));
            },
            child: const Icon(Icons.restaurant),
          ),
        ),
      ),
    );
  }
}
