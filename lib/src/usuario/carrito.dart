import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> realizarCompra(BuildContext context) async {
    try {
      final firestore = FirebaseFirestore.instance;

      //crear el pedido
      final pedido = {
        'productos': carrito,
        'total': calcularTotal(),
        'fecha': DateTime.now(),
        'estado': 'Pendiente',
      };

      //Guardar el pedido en Firestore
      await firestore.collection('pedidos').add(pedido);

      await enviarNotificacion(
        'Nuevo pedido recibido',
        'Tiene un nuevo pedido pendiente',
      );
      await enviarNotificacion(
        'Nuevo pedido disponible',
        'Hay un nuevo pedido para entregar.',
      );

      //Mostrar alertas
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pedido enviado a la empresa y al domiciliario.'),
        ),
      );

      carrito.clear();
      (context as Element).markNeedsBuild();
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el pedido: $e')),
      );
    }
  }

  Future<void> enviarNotificacion(String titulo, String mensaje) async {
    final firestore = FirebaseFirestore.instance;

    //Guardar notificacion en Firestore
    await firestore.collection('notificaciones').add({
      'titulo': titulo,
      'mensaje': mensaje,
      'fecha': DateTime.now(),
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
                            onLongPress: () {
                              //Mostrar un cuadro de dialogo para confirmar la eliminacion
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Eliminar producto'),
                                      content: Text(
                                          '¿Deseas eliminar este producto ${producto['nombreProducto'] ?? 'No tiene nombre'} del carrito de compras?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            carrito.removeAt(index);
                                            Navigator.of(context).pop();
                                            (context as Element)
                                                .markNeedsBuild();
                                          },
                                          child: const Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total: \$${calcularTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (carrito.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'El carrito esta Vacio. No se puede realizar la compra.'),
                                ),
                              );
                              return;
                            }

                            //Logica para enviar alertas
                            await realizarCompra(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white),
                          child: const Text('Comprar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
