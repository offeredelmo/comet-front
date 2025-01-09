import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:flutter/material.dart';

class TarjetaRecetaModeloGrande extends StatelessWidget {
  final RecetaEntity receta;
  const TarjetaRecetaModeloGrande({
    super.key,
    required this.receta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(217, 217, 217, 0.2),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        receta.imgUrl!,
                        height: 140,
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.grey, // Color de fondo alternativo
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.white, // Icono para indicar error
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(receta.title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dificultad: ${"dificil"}\ningredientes: ${receta.ingredientsQuantity}",
                          style: const TextStyle(fontSize: 13),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/actualizar_receta",
                                  arguments: receta);
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white),
                          child: const Row(
                            children: [
                              Icon(Icons.star_border_outlined),
                              SizedBox(
                                width: 3,
                              ),
                              Text("3.1")
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(
                                width: 3,
                              ),
                              Text("${receta.timePreparationInMinutes}m")
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}

class TarjetaRecetaModeloGrandeIconoGuardar extends StatelessWidget {
  const TarjetaRecetaModeloGrandeIconoGuardar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(217, 217, 217, 0.2),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://recetasdecocina.elmundo.es/wp-content/uploads/2024/11/arroz-con-leche.jpg",
                        height: 140,
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Titulo de la receta"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dificultad: ${"dificil"}\ningredientes: ${"100"}",
                          style: TextStyle(fontSize: 11),
                        ),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white),
                          child: Row(
                            children: [
                              const Icon(Icons.star_border_outlined),
                              SizedBox(
                                width: 3,
                              ),
                              Text("3.1")
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white),
                          child: Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(
                                width: 3,
                              ),
                              Text("15m")
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.bookmark))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
