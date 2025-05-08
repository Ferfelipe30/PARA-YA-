import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarProducto extends StatefulWidget {
  final Map<String, dynamic> producto;

  const EditarProducto({super.key, required this.producto});

  @override
  State<EditarProducto> createState() => EditarProductoPage();
}

class EditarProductoPage extends State<EditarProducto> {
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  late TextEditingController precioController;

  @override
  void initState() {
    super.initState();
    nombreController =
        TextEditingController(text: widget.producto['nombreProducto']);
    descripcionController =
        TextEditingController(text: widget.producto['descripcionProducto']);
    precioController = TextEditingController(
        text: widget.producto['precioProducto'].toString());
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    precioController.dispose();
    super.dispose();
  }

  void actualizarProducto() async {
    try {
      await FirebaseFirestore.instance
          .collection('producto')
          .doc(widget.producto['id'])
          .update({
        'nombreProducto': nombreController.text,
        'descripcionProducto': descripcionController.text,
        'precioProducto': double.parse(precioController.text),
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto actualizado exitosamente')),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descripcionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion del producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: precioController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Precio del producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: actualizarProducto,
                  child: const Text('Actualizar producto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
