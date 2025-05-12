// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/carrito.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';
import 'package:para_ya/src/usuario/productoDetalle.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homePage();
}

// ignore: camel_case_types
class homePage extends State<home> {
  final buscar = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> carrito = [];

  double calcularTotal() {
    return carrito.fold(0, (total, producto) {
      return total + (producto['precioProducto'] ?? 0);
    });
  }

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
          drawer: const navDrawer(),
          appBar: AppBar(
            title: TextField(
                controller: buscar,
                decoration: const InputDecoration(
                    hintText: 'Buscar', border: InputBorder.none),
                onChanged: (value) {
                  setState(() {});
                }),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Carrito(carrito: carrito),
                    ),
                  );
                },
              ),
            ],
          ),
          body: StreamBuilder(
              stream: firestore.collection('producto').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final productos = snapshot.data!.docs.where((document) {
                  final nombreProducto = (document.data()
                          as Map<String, dynamic>)['nombreProducto'] ??
                      '';
                  return nombreProducto
                      .toLowerCase()
                      .contains(buscar.text.toLowerCase());
                }).toList();

                if (productos.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron productos'),
                  );
                }

                return ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final document = productos[index];
                      final data = document.data() as Map<String, dynamic>;

                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductoDetalle(productData: data)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    data.containsKey('imageUrl') &&
                                            data['imageUrl'] != null
                                        ? Image.network(
                                            data['imageUrl'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['nombreProducto'] ??
                                                'Sin nombre',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            data['descripcionProducto'] ??
                                                'Sin descripción',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            data.containsKey('precioProducto')
                                                ? '\$${data['precioProducto']}'
                                                : 'Sin precio',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            carrito.add(data);
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${data['nombreProducto']} agrear al carrito.',
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white),
                                        child: const Text('Comprar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
