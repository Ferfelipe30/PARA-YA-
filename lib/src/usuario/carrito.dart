import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

class Carrito extends StatelessWidget {
  final List<Map<String, dynamic>> carrito;

  const Carrito({super.key, required this.carrito});

  double calcularTotal() {
    return carrito.fold(0, (total, producto) {
      return total + (producto['precioProducto'] ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      drawer: const navDrawer(),
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cityfondo.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: carrito.isEmpty
            ? const Center(
                child: Text('El carrito esta vacio.'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: carrito.length,
                        itemBuilder: (context, index) {
                          final producto = carrito[index];
                          return ListTile(
                            leading: producto.containsKey('imageUrl') &&
                                    producto['imageUrl'] != null
                                ? Image.network(producto['imageUrl'])
                                : const Icon(Icons.image),
                            title: Text(producto['nombreProducto'] ??
                                'No tiene nombre producto'),
                            subtitle: Text(
                                'Precio: ${producto['precioProducto'] ?? 0}'),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Total: \$${calcularTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
