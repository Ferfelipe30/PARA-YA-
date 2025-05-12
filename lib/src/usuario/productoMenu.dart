import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/carrito.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';
import 'package:para_ya/src/usuario/productoDetalle.dart';

// ignore: camel_case_types
class productoMenu extends StatefulWidget {
  const productoMenu({super.key});

  @override
  State<productoMenu> createState() => productoMenuPage();
}

// ignore: camel_case_types
class productoMenuPage extends State<productoMenu> {
  final buscar = TextEditingController();
  String? categoriaSeleccionada;
  final List<String> categorias = [
    'Todos',
    'Comida',
    'Bebidas',
    'Postres',
    'Snacks',
  ];

  //Lista para almacenar los productos seleccionados
  final List<Map<String, dynamic>> carrito = [];

  //Funcion para calcular el total
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
            title: const Text('Menu Productos'),
            centerTitle: true,
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                    value: categoriaSeleccionada,
                    hint: const Text('Selecciona Categoria'),
                    isExpanded: true,
                    items: categorias.map((String categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),
                    onChanged: (String? nuevaCategoria) {
                      setState(() {
                        categoriaSeleccionada = nuevaCategoria;
                      });
                    }),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: categoriaSeleccionada == null ||
                            categoriaSeleccionada == 'Todos'
                        ? FirebaseFirestore.instance
                            .collection('producto')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('producto')
                            .where('categoria',
                                isEqualTo: categoriaSeleccionada)
                            .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var document = snapshot.data!.docs[index];
                          var data = document.data() as Map<String, dynamic>;

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
                                  Text(
                                    data.containsKey('descripcionProducto')
                                        ? data['descripcionProducto']
                                        : 'Sin descripcion',
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    data.containsKey('precioProducto')
                                        ? '\$${data['precioProducto']}'
                                        : 'Precio no disponible',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        carrito.add(
                                            data); //Agregar el producto al carrito
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${data['nombreProducto']} agregado al carrito.',
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .blueAccent, // Color del botón
                                        foregroundColor: Colors.black),
                                    child: const Text('Agregar al carrito'),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductoDetalle(
                                      productData: data,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
