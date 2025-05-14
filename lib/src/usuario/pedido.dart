import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pedido extends StatelessWidget {
  final DocumentSnapshot pedido;

  const Pedido({super.key, required this.pedido});

  String getStatusDescription(String estado) {
    switch (estado.toLowerCase()) {
      case 'aceptado':
        return 'Tu pedido ha sido aceptado';
      case 'pendiente':
        return 'Tu pedido ha sido recibido y está pendiente de confirmación.';
      case 'en_preparacion':
        return 'Tu pedido está siendo preparado.';
      case 'entregado_domiciliario':
        return 'Tu pedido ha sido entregado al repartidor y está en camino.';
      case 'entregado':
        return 'Tu pedido ha sido entregado.';
      case 'cancelado':
        return 'Tu pedido ha sido cancelado.';
      default:
        return 'Estado desconocido.';
    }
  }

  IconData getStatusIcon(String estado) {
    switch (estado.toLowerCase()) {
      case 'aceptado':
        return Icons.check_circle;
      case 'pendiente':
        return Icons.schedule;
      case 'en_preparacion':
        return Icons.restaurant_menu;
      case 'entregado_domiciliario':
        return Icons.delivery_dining;
      case 'entregado':
        return Icons.check_circle;
      case 'cancelado':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = pedido.data() as Map<String, dynamic>;
    final productos = List<Map<String, dynamic>>.from(data['productos'] ?? []);
    final total = data['total'] ?? 0;
    final fecha = (data['fecha'] as Timestamp?)?.toDate() ?? DateTime.now();
    final estado = data['estado'] ?? 'Desconocido';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Pedido'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text('ID del Pedido: ${pedido.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Fecha: ${fecha.day}/${fecha.month}/${fecha.year} - ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 16)),
                Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),
                ListTile(
                  leading: Icon(getStatusIcon(estado), size: 40, color: Theme.of(context).primaryColor), // Adapt color to your theme
                  title: Text('Estado: $estado', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(getStatusDescription(estado), style: const TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 15),
                const Text('Productos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                ...productos.map((producto) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text(
                      '- ${producto['nombreProducto']} (\$${producto['precioProducto']}) x ${producto['cantidad'] ?? 1}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                // ignore: unnecessary_to_list_in_spreads
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}