import 'package:comet/core/recetas/presentation/screens/mis_ingredientes.dart';
import 'package:comet/core/recetas/presentation/screens/mis_recetas.dart';
import 'package:flutter/material.dart';

import '../widgets/otras_categiras.widget.dart';
import '../widgets/tarjeta_receta_modelo_pequeño.widget.dart';
import '../widgets/tiempos.widget.dart';
import 'recetas_guardadas.dart';

List<String> ejemplo = ["hola1", "hola1", "hola1"];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  List<Widget> listaWidgets = [
    _BodyHome(),
    MisRecetasBody(),
    RecetasGuardadas(),
    MisIngredientes()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COMET"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber.shade100,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "home"),
          NavigationDestination(
              icon: Icon(Icons.article_outlined), label: "mis recetas"),
          NavigationDestination(
              icon: Icon(Icons.bookmark_border_outlined), label: "guardados"),
          NavigationDestination(
              icon: Icon(Icons.shopping_basket_outlined), label: "ingredientes")
        ],
      ),
      body: listaWidgets[currentPageIndex],
    );
  }
}

class _BodyHome extends StatefulWidget {
  @override
  State<_BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<_BodyHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          const TiemposWidget(),
          const SizedBox(height: 10),
          const OtrasCategoriasWidget(),
          const SizedBox(
            height: 10,
          ),
          ListaRecetasHome()
        ],
      ),
    );
  }
}

class ListaRecetasHome extends StatelessWidget {
  const ListaRecetasHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(7),
        itemCount: ejemplo.length,
        itemBuilder: (context, index) {
          return const Column(
            children: [
              Row(
                children: [
                  Expanded(child: TarjetaRecetaModeloPequeno()),
                  SizedBox(width: 5),
                  Expanded(child: TarjetaRecetaModeloPequeno()),
                ],
              ),
              SizedBox(height: 5),
            ],
          );
        },
      ),
    );
  }
}
