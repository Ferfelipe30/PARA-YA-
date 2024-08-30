// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class inicioSeccion extends StatefulWidget {
  const inicioSeccion({super.key});

  @override
  State<inicioSeccion> createState() => inicioSeccionPage();
}

// ignore: camel_case_types
class inicioSeccionPage extends State<inicioSeccion> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: const Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
