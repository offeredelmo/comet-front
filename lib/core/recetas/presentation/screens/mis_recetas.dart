import 'package:flutter/material.dart';

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
              Navigator.popAndPushNamed(context, '/agregar_receta');
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

class TarjetaRecetaModeloGrande extends StatelessWidget {
  const TarjetaRecetaModeloGrande({
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
