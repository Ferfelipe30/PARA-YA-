// ignore_for_file: file_names
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_ya/src/services/selectImage.dart';
import 'package:para_ya/src/services/uploadImage.dart';
//import 'package:para_ya/src/Empresa/menuEmpresa.dart';

// ignore: camel_case_types
class productoNuevoEmpresa extends StatefulWidget {
  const productoNuevoEmpresa({super.key});

  @override
  State<productoNuevoEmpresa> createState() => productoNuevoEmpresaPage();
}

// ignore: camel_case_types
class productoNuevoEmpresaPage extends State<productoNuevoEmpresa> {
  final formKey = GlobalKey<FormState>();
  final nombreProducto = TextEditingController();
  final descripcionProducto = TextEditingController();
  File? image;
  final firebase = FirebaseFirestore.instance;

  @override
  void dispose() {
    nombreProducto.dispose();
    descripcionProducto.dispose();
    super.dispose();
  }

  productoNew() async {
    try {
      await firebase.collection('producto').add({
        'nombreProducto': nombreProducto.text,
        'descripcionProducto': descripcionProducto.text,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error desconocido: $e');
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
                child: Column(
                  children: <Widget>[
                    image != null
                        ? Image.file(image!)
                        : Container(
                            margin: const EdgeInsets.all(10),
                            height: 200,
                            width: 200,
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final XFile? foto = await getFoto();
                            setState(() {
                              image = File(foto!.path);
                            });
                          },
                          child: const Text("Camara"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final XFile? imagen = await getImage();
                            setState(() {
                              image = File(imagen!.path);
                            });
                          },
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
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Producto nuevo registrado'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Error de registro de producto'),
                            backgroundColor: Colors.red,
                          ));
                        }
                        if (image == null) {
                          return;
                        }
                        final uploaded = await uploadImage(image!);
                        if (uploaded) {
                          // ignore: avoid_print
                          print('Se envio la imagen correctamente.');
                        } else {
                          // ignore: avoid_print
                          print('Error de envio de la imagen.');
                        }
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
