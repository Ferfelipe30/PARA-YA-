// ignore_for_file: file_names
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_ya/src/Empresa/menuEmpresa.dart';

// ignore: camel_case_types
class productoNuevoEmpresa extends StatefulWidget {
  const productoNuevoEmpresa({super.key});

  @override
  State<productoNuevoEmpresa> createState() => productoNuevoEmpresaPage();
}

// ignore: camel_case_types
class productoNuevoEmpresaPage extends State<productoNuevoEmpresa> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final nombreProducto = TextEditingController();
  final descripcionProducto = TextEditingController();
  File? image;
  final firebase = FirebaseFirestore.instance;
  final precioProducto = TextEditingController();

  @override
  void dispose() {
    nombreProducto.dispose();
    descripcionProducto.dispose();
    precioProducto.dispose();
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
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading image: $e');
      return null;
    }
  }

  void productoNew() async {
    if (formKey.currentState!.validate()) {
      try {
        String? imageUrl;
        if (image != null) {
          imageUrl = await _uploadImage(image!);
        }
        await firebase.collection('producto').add({
          'nombreProducto': nombreProducto.text,
          'descripcionProducto': descripcionProducto.text,
          'precioProducto': double.parse(precioProducto.text),
          'imageUrl': imageUrl,
          'userID': auth.currentUser!.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto agregado exitosamente')),
        );

        nombreProducto.clear();
        descripcionProducto.clear();
        precioProducto.clear();
        setState(() {
          image = null;
        });

        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const menuEmpresa()));
      } catch (e) {
        if (mounted) {
          // ignore: avoid_print
          print('Error adding product: $e');
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al agregar el producto')));
        }
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
                                color: Colors.black26,
                              )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => pickImage(ImageSource.camera),
                          child: const Text("Camara"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () => pickImage(ImageSource.gallery),
                          child: const Text("Galeria"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: nombreProducto,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre del producto',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 10,
                      controller: descripcionProducto,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descripcion del producto',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(1, 1, 1, 1)),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: precioProducto,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Precio del producto',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(1, 1, 1, 1),
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Nota: El precioo es por unidad.',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
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
                        productoNew();
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
