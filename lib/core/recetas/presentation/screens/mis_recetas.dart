import 'package:flutter/material.dart';

import '../widgets/tarjeta_receta_modelo_grande.widget.dart';

class MisRecetasBody extends StatefulWidget {
  const MisRecetasBody({super.key});

  @override
  State<MisRecetasBody> createState() => _MisRecetasBodyState();
}

class _MisRecetasBodyState extends State<MisRecetasBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/agregar_receta');
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Agregar nueva receta"),
                SizedBox(width: 5),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return const Center(
                    child: TarjetaRecetaModeloGrande(),
                  );
                }))
      ],
    );
  }
}

