
import 'package:flutter/material.dart';

class TarjetaRecetaModeloPequeno extends StatelessWidget {
  const TarjetaRecetaModeloPequeno({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://recetasdecocina.elmundo.es/wp-content/uploads/2024/11/arroz-con-leche.jpg",
              height: 120,
              width: MediaQuery.of(context).size.width * 0.99,
              fit: BoxFit.cover,
            ),
          ),
          Text("Titulo de la receta"),
          Text(
            "Author: ${"nombre del usuario"}",
            style: TextStyle(fontSize: 10),
          ),
          Text(
            "Dificultad: ${"dificil"}",
            style: TextStyle(fontSize: 11),
          ),
          Text(
            "ingredientes: ${"20/100"}",
            style: TextStyle(fontSize: 11),
          ),
          Row(
            children: const [
              Chip(
                avatar: Icon(Icons.star_border_outlined),
                label: Text(
                  "3.2",
                  style: TextStyle(fontSize: 13),
                ),
                padding: EdgeInsets.all(0),
              ),
              SizedBox(
                width: 6,
              ),
              Chip(
                avatar: Icon(Icons.timer_outlined),
                label: Text(
                  "15m",
                  style: TextStyle(fontSize: 13),
                ),
                padding: EdgeInsets.all(0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
