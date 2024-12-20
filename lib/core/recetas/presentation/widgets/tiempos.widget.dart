
import 'package:flutter/material.dart';

class TiemposWidget extends StatelessWidget {
  const TiemposWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(217, 217, 217, 0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea al inicio en el eje horizontal
        children: [
          const Text("Tiempos"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: const Text("Desayuno"),),
              const SizedBox(width: 5),
              OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),   child: const Text("Comida")),
              const SizedBox(width: 5),
              OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),  child: const Text("Cena")),
            ],
          ),
        ],
      ),
    );
  }
}
