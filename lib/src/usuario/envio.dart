import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Import the detail screen
import 'package:para_ya/src/usuario/navDrawer.dart';
import 'package:para_ya/src/usuario/pedido.dart';

// ignore: camel_case_types
class envio extends StatefulWidget {
  const envio({super.key});

  @override
  State<envio> createState() => envioPage();
}

// ignore: camel_case_types
class envioPage extends State<envio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 255, 255, 255),
      drawer: const navDrawer(),
      appBar: AppBar(
        title: const Text('Envio'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cityfondo.webp'),
              fit: BoxFit.cover),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('pedidos').orderBy('fecha', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No has realizado ningún pedido aún.'));
            }

            final pedidos = snapshot.data!.docs;

            return ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                final data = pedido.data() as Map<String, dynamic>;
                final total = data['total'] ?? 0.0;
                final fecha = (data['fecha'] as Timestamp?)?.toDate() ?? DateTime.now();
                final estado = data['estado'] ?? 'Desconocido';
                // final productos = List<Map<String, dynamic>>.from(data['productos'] ?? []);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pedido(pedido: pedido),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text('Pedido ID: ${pedido.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fecha: ${fecha.day}/${fecha.month}/${fecha.year} - ${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}'),
                          Text('Total: \$${total.toStringAsFixed(2)}'),
                          Text(
                            'Estado: $estado',
                            style: TextStyle(fontWeight: FontWeight.bold, color: _getStatusColor(estado)),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward), // Added trailing icon to indicate navigability
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
  Color _getStatusColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'en_preparacion': // Assuming you might have this status
        return Colors.blue;
      case 'entregado_domiciliario':
        return Colors.purple;
      case 'entregado': // Assuming a final "delivered to customer" status
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
