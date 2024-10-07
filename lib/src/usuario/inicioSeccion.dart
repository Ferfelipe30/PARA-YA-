// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_ya/src/usuario/home.dart';
import 'package:uuid/uuid.dart';

// ignore: camel_case_types
class inicioSeccion extends StatefulWidget {
  const inicioSeccion({super.key});

  @override
  State<inicioSeccion> createState() => inicioSeccionPage();
}

// ignore: camel_case_types
class inicioSeccionPage extends State<inicioSeccion> {
  final formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;
  File? image;
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final email = TextEditingController();
  final celular = TextInputType.phone;
  final contrasena = TextEditingController();
  final fechaNacimiento = TextEditingController();
  final pais = TextEditingController();
  final departamento = TextEditingController();
  final ciudad = TextEditingController();
  final direccion = TextEditingController();
  final descripcion = TextEditingController();
  final ImagePicker picker = ImagePicker();

  loginUsuario() async {
    try {
      String userId = const Uuid().v4();
      String? imageUrl;
      if (image != null) {
        final storegeRef =
            FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
        await storegeRef.putFile(image!);
        imageUrl = await storegeRef.getDownloadURL();
      }

      await firebase.collection('usuario').add({
        'profileImageUrl': imageUrl,
        'nombreUsuario': nombre.text,
        'apellidoUsuario': apellido.text,
        'emailUsuario': email.text,
        'celularUsuario': celular.index,
        'contraseñaUsuario': contrasena.text,
        'fechaNacimientoUsuario': fechaNacimiento.text,
        'paisUsuario': pais.text,
        'departamentoUsuario': departamento.text,
        'ciudadUsuario': ciudad.text,
        'direccionUsuario': direccion.text,
        'descripcionUsuario': descripcion.text,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error ...$e');
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
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      image != null
                          ? Image.file(image!)
                          : const Text('No hay imagen seleccionada'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
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
                            child: const Text('Tomar foto'),
                          ),
                          ElevatedButton(
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
                            child: const Text('Seleciona desde galeria'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: nombre,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre',
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
                        controller: apellido,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Apellidos',
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
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
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
                        keyboardType: celular,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Numero de Celular',
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
                        controller: contrasena,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contraseña',
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
                        controller: fechaNacimiento,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fecha de Nacimiento',
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
                        controller: pais,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Pais',
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
                        controller: departamento,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Departamento',
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
                        controller: ciudad,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ciudad',
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
                        controller: direccion,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Direccion',
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
                        maxLines: 5,
                        controller: descripcion,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descripcion del lugar donde vive. ',
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
                          backgroundColor:
                              const Color.fromRGBO(255, 243, 13, 1),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            loginUsuario();
                            // ignore: avoid_print
                            print('...Enviado');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Nuevo Usuario Registrado'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const home()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Error de registro de nuevo usuario'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('Registrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
