import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PedidoEmpresa extends StatelessWidget {
  final DocumentSnapshot pedido;

  const PedidoEmpresa({super.key, required this.pedido});

  Future<void> confirmDelivery(BuildContext context) async {
    try {
      await pedido.reference.update({'estado': 'entregado_domiciliario'});

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pedido confirmado para entregar al domiciliario.'),
      backgroundColor: Colors.green,),);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al confirmar el pedido: $e'),
        backgroundColor: Colors.red,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = pedido.data() as Map<String, dynamic>;
    final productos = List<Map<String, dynamic>>.from(data['productos'] ?? []);
    final total = data['total'] ?? 0;
    final fecha = (data['fecha'] as Timestamp).toDate();
    final estado = data['estado'] ?? 'pendiente';

    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Detalle del pedido'),
        leading: const BackButton(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cityfondo.webp'),
            fit: BoxFit.cover, 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text('ID del Pedido: ${pedido.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Text('Fecha: ${fecha.toLocal()}', style: const TextStyle(fontSize: 16)),
                Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                Text('Estado: $estado', style: const TextStyle(fontSize: 16)), // Display status
                const SizedBox(height: 15),
                const Text('Productos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                ...productos.map((producto) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text(
                      '- ${producto['nombreProducto']} (\$${producto['precioProducto']}) x ${producto['cantidad'] ?? 1}', // Assuming quantity might exist
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                // ignore: unnecessary_to_list_in_spreads
                }).toList(),
                const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => confirmDelivery(context),
                    child: const Text('Confirmar Entrega al Domiciliario'),
                  ),
                  if (estado != 'pendiente')
                   Center(
                     child: Text(
                       'Estado actual: $estado',
                       style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                     ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}