import 'package:comet/core/recetas/presentation/screens/agregar_receta.dart';
import 'package:flutter/material.dart';

import 'core/recetas/presentation/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
     routes: {
        "/": (context) => const Home(), // Aquí estaba el problema
        "/agregar_receta": (context) => const AgregarReceta()
      },
    );
  }
}

