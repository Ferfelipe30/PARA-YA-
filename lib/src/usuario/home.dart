// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/src/usuario/navDrawer.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homePage();
}

// ignore: camel_case_types
class homePage extends State<home> {
  final buscar = TextEditingController();
  final firestore = FirebaseFirestore.instance;

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
              backgroundColor: Colors.white,
              drawer: const navDrawer(),
              appBar: AppBar(
                title: TextField(
                  controller: buscar,
                  decoration: const InputDecoration(
                      hintText: 'Buscar', border: InputBorder.none),
                ),
              ),
              body: StreamBuilder(
                  stream: firestore.collection('producto').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No hay productos registrados.'),
                      );
                    }
                    final products = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final producto = products[index];
                          final data = producto.data() as Map<String, dynamic>;
                          final nombre = data.containsKey('nombreProducto')
                              ? data['nombreProducto']
                              : 'Nombre no disponible';
                          final descripcion =
                              data.containsKey('descripcionProducto')
                                  ? data['descripcionProducto']
                                  : 'Descripción no disponible';
                          final imagenUrl = data.containsKey('imagenUrl')
                              ? data['imagenUrl']
                              : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.123rf.com%2Fphoto_104615274_stock-vector-no-image-available-icon-flat-vector.html&psig=AOvVaw3';

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(imagenUrl),
                            ),
                            title: Text(nombre),
                            subtitle: Text(descripcion),
                          );
                        });
                  }))),
    );
  }
}
