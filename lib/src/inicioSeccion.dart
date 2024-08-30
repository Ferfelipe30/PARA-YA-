// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_ya/src/home.dart';

// ignore: camel_case_types
class inicioSeccion extends StatefulWidget {
  const inicioSeccion({super.key});

  @override
  State<inicioSeccion> createState() => inicioSeccionPage();
}

// ignore: camel_case_types
class inicioSeccionPage extends State<inicioSeccion> {
  final formKey = GlobalKey<FormState>();
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
                      nombreUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      apellidoUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      emailUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      const celularUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      contrasenaUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      fechaNacimientoUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      paisUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      departamentoUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      ciudadUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      descripcionDireccionUsuario(),
                      const SizedBox(
                        height: 10,
                      ),
                      const botonNewUsuario(),
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

// ignore: camel_case_types
class nombreUsuario extends StatelessWidget {
  nombreUsuario({super.key});
  final nombre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: nombre,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nombre',
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
class apellidoUsuario extends StatelessWidget {
  apellidoUsuario({super.key});
  final apellido = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: apellido,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Apellidos',
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
class emailUsuario extends StatelessWidget {
  emailUsuario({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: email,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
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
class celularUsuario extends StatelessWidget {
  const celularUsuario({super.key});
  final celular = TextInputType.phone;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: celular,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Numero de Celular',
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
class contrasenaUsuario extends StatelessWidget {
  contrasenaUsuario({super.key});
  final contrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: contrasena,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contraseña',
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
class fechaNacimientoUsuario extends StatelessWidget {
  fechaNacimientoUsuario({super.key});
  final fechaNacimiento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: fechaNacimiento,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Fecha de Nacimiento',
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
class paisUsuario extends StatelessWidget {
  paisUsuario({super.key});
  final pais = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: pais,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Pais',
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
class departamentoUsuario extends StatelessWidget {
  departamentoUsuario({super.key});
  final departamento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: departamento,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Departamento',
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
class ciudadUsuario extends StatelessWidget {
  ciudadUsuario({super.key});
  final ciudad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: ciudad,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Ciudad',
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
class direccionUsuario extends StatelessWidget {
  direccionUsuario({super.key});
  final direccion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: direccion,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Direccion',
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
class descripcionDireccionUsuario extends StatelessWidget {
  descripcionDireccionUsuario({super.key});
  final descripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      controller: descripcion,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Descripcion del lugar donde vive. ',
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
class botonNewUsuario extends StatelessWidget {
  const botonNewUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const home()));
      },
      child: const Text('Registrar'),
    );
  }
}
