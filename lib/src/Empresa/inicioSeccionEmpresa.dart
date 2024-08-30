// ignore_for_file: file_names
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
                        nombreEmpresa(),
                        const SizedBox(
                          height: 10,
                        ),
                        emailEmpresa(),
                        const SizedBox(
                          height: 10,
                        ),
                        empresaTipo(),
                        const SizedBox(
                          height: 10,
                        ),
                        const paisEmpresa(),
                        const SizedBox(
                          height: 10,
                        ),
                        const departamentoEmpresa(),
                        const SizedBox(
                          height: 10,
                        ),
                        ciudadEmpresa(),
                        const SizedBox(
                          height: 10,
                        ),
                        direccionLocal(),
                        const SizedBox(
                          height: 10,
                        ),
                        const celularEmpresa(),
                        const SizedBox(
                          height: 15,
                        ),
                        const buttonNewEmpresa(),
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

// ignore: camel_case_types
class nombreEmpresa extends StatelessWidget {
  nombreEmpresa({super.key});
  final nombre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: nombre,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nombre de la Empresa',
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
class emailEmpresa extends StatelessWidget {
  emailEmpresa({super.key});
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: email,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email de la Empresa',
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
class empresaTipo extends StatelessWidget {
  empresaTipo({super.key});
  final tipoEmpresa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: tipoEmpresa,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '¿Que tipo de empresa es?',
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
class paisEmpresa extends StatefulWidget {
  const paisEmpresa({super.key});

  @override
  paisEmpresaPage createState() => paisEmpresaPage();
}

// ignore: camel_case_types
class paisEmpresaPage extends State<paisEmpresa> {
  String? paiss;
  List<String> paises = [
    'Argentina',
    'Bolivia',
    'Brasil',
    'Chile',
    'Colombia',
    'Ecuador',
    'Guyana',
    'Paraguay',
    'Perú',
    'Surinam',
    'Uruguay',
    'Venezuela',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'País',
        border: OutlineInputBorder(),
      ),
      value: paiss,
      items: paises.map<DropdownMenuItem<String>>((String pais) {
        return DropdownMenuItem<String>(
          value: pais,
          child: Text(pais),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          paiss = newValue;
        });
      },
    );
  }
}

// ignore: camel_case_types
class departamentoEmpresa extends StatefulWidget {
  const departamentoEmpresa({super.key});

  @override
  departamentoEmpresaPage createState() => departamentoEmpresaPage();
}

// ignore: camel_case_types
class departamentoEmpresaPage extends State<departamentoEmpresa> {
  String? departamento;
  List<String> departamentos = [
    'Amazonas',
    'Antioquía',
    'Arauca',
    'Atlántico',
    'Bolívar',
    'Boyacá',
    'Caldas',
    'Caquetá',
    'Casanare',
    'Cauca',
    'Cesar',
    'Chocó',
    'Córdoba',
    'Cundinamarca',
    'Guainía',
    'Guaviare',
    'Huila',
    'La Guajira',
    'Magdalena',
    'Meta',
    'Nariño',
    'Norte de Santander',
    'Putumayo',
    'Quindío',
    'Risaralda',
    'San Andrés y Providencia',
    'Santander',
    'Sucre',
    'Tolima',
    'Valle del Cauca',
    'Vaupés',
    'Vichada',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Departamento',
        border: OutlineInputBorder(),
      ),
      value: departamento,
      items: departamentos.map<DropdownMenuItem<String>>((String depart) {
        return DropdownMenuItem<String>(
          value: depart,
          child: Text(depart),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          departamento = newValue;
        });
      },
    );
  }
}

// ignore: camel_case_types
class celularEmpresa extends StatelessWidget {
  const celularEmpresa({super.key});
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
class direccionLocal extends StatelessWidget {
  direccionLocal({super.key});
  final direccion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: direccion,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Direccion del Local',
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
class ciudadEmpresa extends StatelessWidget {
  ciudadEmpresa({super.key});
  final ciudad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: ciudad,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Ciudad donde se encuentra',
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
class buttonNewEmpresa extends StatelessWidget {
  const buttonNewEmpresa({super.key});

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
      child: const Text('Registrar'),
    );
  }
}
