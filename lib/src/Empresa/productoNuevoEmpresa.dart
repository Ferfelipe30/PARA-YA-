// ignore_for_file: file_names
import 'dart:io';

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
  final nombre = TextEditingController();
  final descripcion = TextEditingController();
  final precio = TextEditingController();
  File? image;

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
                    // ignore: unnecessary_null_comparison
                    image != null
                        ? Image.file(image!)
                        : const Text('No hay imagen seleccionada'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text('Tomar foto'),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              if (pickedFile != null) {
                                image = File(pickedFile.path);
                              } else {
                                image = null;
                              }
                            });
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Seleccionar desde galería'),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              if (pickedFile != null) {
                                image = File(pickedFile.path);
                              } else {
                                image = null;
                              }
                            });
                          },
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
                    const buttonProductoNew(),
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
class buttonProductoNew extends StatelessWidget {
  const buttonProductoNew({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const menuEmpresa()));
      },
      child: const Text('Guardar'),
    );
  }
}
