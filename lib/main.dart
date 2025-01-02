import 'package:comet/core/di.dart';
import 'package:comet/core/recetas/domain/use_case/buscador_de_recetas.dart';
import 'package:comet/core/recetas/presentation/blocks/agregar_receta_bloc.dart';
import 'package:comet/core/recetas/presentation/blocks/buscador_receta_bloc.dart';
import 'package:comet/core/recetas/presentation/screens/agregar_receta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/recetas/presentation/screens/home.dart';

void main() async {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance.get<AgregarRecetaBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<BuscadorRecetaBloc>())

      ],
      child: MaterialApp(
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
      ),
    );
  }
}
