// ignore_for_file: file_names
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:para_ya/src/Empresa/productosMenu.dart';

// ignore: camel_case_types
class productoNew extends StatefulWidget {
  const productoNew({super.key});

  @override
  State<productoNew> createState() => productoNewPage();
}

// ignore: camel_case_types
class productoNewPage extends State<productoNew> {
  final formKey = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final precio = TextEditingController();
  File? image;
  final firebase = FirebaseFirestore.instance;

  @override
  void dispose() {
    nombre.dispose();
    descripcion.dispose();
    precio.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadTask = await snapshot.ref.getDownloadURL();
      return downloadTask;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading image: $e');
      return null;
    }
  }

  void nuevoProducto() async {
    if (formKey.currentState!.validate()) {
      try {
        String? imageUrl;
        if (image != null) {
          imageUrl = await _uploadImage(image!);
        }
        await firebase.collection('producto').add({
          'nombreProducto': nombre.text,
          'descripcionProducto': descripcion.text,
          'precioProducto': double.parse(precio.text),
          'imageUrl': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto agregado exitosamente')));

        nombre.clear();
        descripcion.clear();
        setState(() {
          image = null;
        });

        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const productosMenu(),
            ));
      } catch (e) {
        // ignore: avoid_print
        print('Error adding product: $e');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al agregar el producto')));
      }
    }
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
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(10),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            )),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.black,
                              )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text('Camara'),
                          onPressed: () => pickImage(ImageSource.camera),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: const Text('Galeria'),
                          onPressed: () => pickImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    nombreProducto(),
                    const SizedBox(
                      height: 10,
                    ),
                    descripcionProducto(),
                    const SizedBox(
                      height: 10,
                    ),
                    precioProducto(),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () async {
                        nuevoProducto();
                        // ignore: avoid_print
                        print('...Enviado');
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class nombreProducto extends StatelessWidget {
  nombreProducto({super.key});
  final nombre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: nombre,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nombre del producto',
        labelStyle: TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class descripcionProducto extends StatelessWidget {
  descripcionProducto({super.key});
  final descripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      controller: descripcion,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Descripcion del producto',
        labelStyle: TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class precioProducto extends StatelessWidget {
  precioProducto({super.key});
  final precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: precio,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Precio del producto',
        labelStyle: TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese el precio del producto';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor ingrese un numero valido';
        }
        return null;
      },
    );
  }
}
