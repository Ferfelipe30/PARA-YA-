// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:para_ya/src/Empresa/menuEmpresa.dart';

// ignore: camel_case_types
class inicioSeccionEmpresa extends StatefulWidget {
  const inicioSeccionEmpresa({super.key});

  @override
  State<inicioSeccionEmpresa> createState() => inicioSeccionEmpresaPage();
}

// ignore: camel_case_types
class inicioSeccionEmpresaPage extends State<inicioSeccionEmpresa> {
  final formKey = GlobalKey<FormState>();
  final firebase = FirebaseFirestore.instance;
  final nombre = TextEditingController();
  final email = TextEditingController();
  final tipoEmpresa = TextEditingController();
  final pais = TextEditingController();
  final departamento = TextEditingController();
  final ciudad = TextEditingController();
  final direccion = TextEditingController();
  final celular = TextInputType.phone;

  loginEmpresa() async {
    try {
      await firebase.collection('empresas').doc().set({
        'nombreEmpresa': nombre.text,
        'emailEmpresa': email.text,
        'celular': celular.index,
        'tipoEmpresa': tipoEmpresa.text,
        'pais': pais.text,
        'departamento': departamento.text,
        'ciudad': ciudad.text,
        'direccion': direccion.text,
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
                        TextFormField(
                          maxLines: 1,
                          controller: nombre,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre de la empresa',
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
                            labelText: 'Email de la Empresa',
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
                          controller: tipoEmpresa,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '¿Que tipo de empresa es?',
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
                            labelText: 'Direccion del Local',
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
                          height: 15,
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
                            loginEmpresa();
                            // ignore: avoid_print
                            print('...Enviado');
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nuevo Usuario registrado'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const menuEmpresa()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Error de registro de nuevo usuario'),
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
          )),
    );
  }
}
