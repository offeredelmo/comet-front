import 'package:flutter/material.dart';

import '../widgets/tarjeta_receta_modelo_grande.widget.dart';



class RecetasGuardadas extends StatefulWidget {
  const RecetasGuardadas({super.key});

  @override
  State<RecetasGuardadas> createState() => _RecetasGuardadasState();
}

class _RecetasGuardadasState extends State<RecetasGuardadas> {
  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
       
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return const Center(
                    child: TarjetaRecetaModeloGrandeIconoGuardar(),
                  );
                }))
      ],
    );
  }
}