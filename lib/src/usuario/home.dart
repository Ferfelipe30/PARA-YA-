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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: firestore.collection('producto').snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          final products = snapshot.data!.docs;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return ListTile(
                                      title: Text(product['nombreProducto']),
                                      subtitle:
                                          Text(product['descripcionProducto']),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        })
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
