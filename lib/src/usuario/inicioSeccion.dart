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
  bool isObscured = true;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${const Uuid().v4()}.jpg');
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

  Future<void> loginUsuario() async {
    try {
      String? imageUrl;
      if (image != null) {
        imageUrl = await uploadImage(image!);
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => pickImage(ImageSource.camera),
                            child: const Text('Camara'),
                          ),
                          ElevatedButton(
                            onPressed: () => pickImage(ImageSource.gallery),
                            child: const Text('Galeria'),
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
                        obscureText: isObscured,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(1, 1, 1, 1)),
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(1, 1, 1, 1)),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                                icon: Icon(
                                  isObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ))),
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
