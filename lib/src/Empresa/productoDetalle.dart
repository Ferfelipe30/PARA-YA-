import 'package:flutter/material.dart';
import 'package:para_ya/src/Empresa/editarProducto.dart';

class ProductoDetalle extends StatelessWidget {
  final Map<String, dynamic> producto;

  const ProductoDetalle({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cityfondo.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                producto['imageUrl'] != null
                    ? Image.network(producto['imageUrl'])
                    : const Icon(
                        Icons.image,
                        size: 100,
                      ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Nombre: ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  producto['nombreProducto'],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text('Descripcion: ',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(producto['descripcionProducto'],
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 16,
                ),
                Text('Precio: ',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text('\$${producto['precioProducto']}'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditarProducto(producto: producto),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
