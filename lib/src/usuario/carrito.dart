import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

class Carrito extends StatefulWidget {
  final List<Map<String, dynamic>> carrito;

  const Carrito({super.key, required this.carrito});

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  String? _selectedPaymentMethod;
  final List<String> _paymentMethods = [
    'Tarjeta de Crédito/Débito (Simulado)',
    'PSE (Simulado)',
    'Efectivo Contraentrega'
  ]; // Ejemplo de métodos de pago

  double calcularTotal() {
    return widget.carrito.fold(0, (total, producto) {
      return total + (producto['precioProducto'] ?? 0);
    });
  }

  Future<void> realizarCompra(BuildContext context) async {
    try {
      if (_selectedPaymentMethod == null || _selectedPaymentMethod!.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, seleccione un método de pago.')),
        );
        return;
      }

      // PASO CRÍTICO: Integración con Pasarela de Pagos
      // Aquí es donde integrarías tu pasarela de pagos (Stripe, PayPal, Mercado Pago, etc.)
      // NUNCA manejes datos sensibles de tarjetas directamente.
      // La pasarela se encargará de la transacción segura.
      // Ejemplo conceptual (debes reemplazar esto con la lógica real de tu pasarela):
      // ignore: avoid_print
      print('Iniciando proceso de pago con: $_selectedPaymentMethod');
      // bool pagoExitoso = await miPasarelaDePagos.procesar(calcularTotal(), _selectedPaymentMethod, /* datos del usuario */);
      // Por ahora, simularemos un pago exitoso después de un breve retraso.
      await Future.delayed(const Duration(seconds: 2));
      bool pagoExitoso = true; // Simulación de pago exitoso

      // ignore: dead_code
      if (!pagoExitoso) {
        if (!mounted) return;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al procesar el pago. Intente de nuevo.')),
        );
        return;
      }

      // Si el pago fue exitoso, continuar con la creación del pedido
      final firestore = FirebaseFirestore.instance;

      //crear el pedido
      final pedido = {
        'productos': widget.carrito,
        'total': calcularTotal(),
        'fecha': DateTime.now(),
        'estado': 'Pendiente',
        'metodoDePago': _selectedPaymentMethod, // Guardar método de pago
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

      if (!mounted) return;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Compra realizada con éxito! Pedido enviado.'),
        ),
      );

      setState(() {
        widget.carrito.clear();
        _selectedPaymentMethod = null; // Resetear método de pago
      });
    } catch (e) {
      if (!mounted) return;
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
        child: widget.carrito.isEmpty
            ? const Center(
                child: Text('El carrito esta vacio.'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: widget.carrito.length,
                        itemBuilder: (context, index) {
                          final producto = widget.carrito[index];
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
                                            if (mounted) Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.carrito.removeAt(index);
                                            });
                                            if (mounted) {
                                               Navigator.of(context).pop();
                                            }
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
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Seleccione Método de Pago',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedPaymentMethod,
                          hint: const Text('Elija cómo pagar'),
                          isExpanded: true,
                          items: _paymentMethods.map((String method) {
                            return DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPaymentMethod = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: \$${calcularTotal().toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (widget.carrito.isEmpty) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'El carrito está vacío. No se puede realizar la compra.'),
                                    ),
                                  );
                                  return;
                                }
                                if (_selectedPaymentMethod == null) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Por favor, seleccione un método de pago.'),
                                    ),
                                  );
                                  return;
                                }
                                await realizarCompra(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                              ),
                              child: const Text('Comprar Ahora'),
                            ),
                          ],
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
