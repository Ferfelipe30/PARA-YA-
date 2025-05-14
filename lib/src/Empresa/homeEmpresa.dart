// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/nav.dart';
import 'package:para_ya/src/Empresa/pedidoEmpresa.dart';// Import the new screen

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
          body: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('pedidos').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No hay pedidos disponibles.'),
                  );
                }

                final pedidos = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: pedidos.length,
                    itemBuilder: (context, index) {
                      final pedido = pedidos[index];
                      // ignore: unused_local_variable
                      final productos = List<Map<String, dynamic>>.from(
                          pedido['productos'] ?? []);
                      final total = pedido['total'] ?? 0;
                      final fecha = (pedido['fecha'] as Timestamp).toDate();

                      return GestureDetector( // Wrap with GestureDetector to make the card tappable
                        onTap: () {
                          // Navigate to the detail screen when the card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PedidoEmpresa(pedido: pedido), // Pass the pedido document
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            // Display a summary in the list view
                            title: Text('Pedido ID: ${pedido.id}'), // Showing ID is helpful
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fecha: ${fecha.toLocal()}'),
                                Text('Total: \$${total.toStringAsFixed(2)}'),
                                // You can add a brief product summary here if needed,
                                // but full details are on the next screen.
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward), // Indicate that tapping leads somewhere
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
