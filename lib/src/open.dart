import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:para_ya/src/Empresa/inicioSeccionEmpresa.dart';
import 'package:para_ya/src/inicioSeccion.dart';

// ignore: camel_case_types
class open extends StatefulWidget {
  const open({super.key});

  @override
  State<open> createState() => openPage();
}

// ignore: camel_case_types
class openPage extends State<open> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/cityfondo.webp'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(197, 255, 255, 255),
          body: Form(
              key: formKey,
              child: const Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        imagenLogo(),
                        SizedBox(
                          height: 50,
                        ),
                        bottonGoogleSeccion(),
                        bottonFacebookSeccion(),
                        SizedBox(
                          height: 10,
                        ),
                        botonesIniciarSecciones(),
                        SizedBox(
                          height: 15,
                        ),
                        olvideContrasena(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class imagenLogo extends StatelessWidget {
  const imagenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.webp',
        fit: BoxFit.contain,
      ),
    );
  }
}

// ignore: camel_case_types
class bottonGoogleSeccion extends StatelessWidget {
  const bottonGoogleSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.google),
        label: const Text(
          "Iniciar Sesión con Google",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class bottonFacebookSeccion extends StatelessWidget {
  const bottonFacebookSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.facebook),
        label: const Text(
          "Iniciar Sesión con Facebook",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class botonesIniciarSecciones extends StatelessWidget {
  const botonesIniciarSecciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const inicioSeccion()));
                },
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(children: <Widget>[
            FloatingActionButton(
              backgroundColor: const Color.fromRGBO(255, 243, 13, 1),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const inicioSeccionEmpresa(),
                    ));
              },
              child: const Icon(
                Icons.store_mall_directory_sharp,
                size: 50,
                color: Colors.black,
              ),
            )
          ]),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class olvideContrasena extends StatelessWidget {
  const olvideContrasena({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Olvide la contraseña',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
