import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/carrito.dart';

class ProductoDetalle extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductoDetalle({super.key, required this.productData});

  final List<Map<String, dynamic>> carrito = [];

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      appBar: AppBar(
        title: Text(productData['nombreProducto'] ?? 'Detalles del producto'),
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
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/cityfondo.webp'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productData.containsKey('imageUrl') &&
                      productData['imageUrl'] != null
                  ? Image.network(
                      productData['imageUrl'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.image,
                      size: 200,
                    ),
              const SizedBox(
                height: 16,
              ),
              Text(
                productData['nombreProducto'] ?? 'Sin nombre',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                productData['descripcionProducto'] ?? 'Sin descripcion',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                productData.containsKey('precioProducto')
                    ? '\$${productData['precioProducto']}'
                    : 'Sin precio',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  //Agregar e producto al carrito
                  carrito.add(productData);

                  //Mostrar un mensaje de confirmacion
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${productData['nombreProducto']} agregar al carrito de compras'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text('Agregar al carrito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
