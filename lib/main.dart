import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:para_ya/firebase_options.dart';
import 'package:para_ya/src/open.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 40, 50, 182)),
        useMaterial3: true,
      ),
      home: const open(),
    );
  }
}
