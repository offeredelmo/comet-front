

import 'package:flutter/material.dart';

class OtrasCategoriasWidget extends StatelessWidget {
  const OtrasCategoriasWidget({
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
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea al inicio en el eje horizontal
        children: [
          const Text("Otras categorias"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(217, 217, 217, 0.2),
                      ),
                    ),
                  ),
                  const Text("Postres")
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(217, 217, 217, 0.2),
                      ),
                    ),
                  ),
                  const Text("Snacks")
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(217, 217, 217, 0.2),
                      ),
                    ),
                  ),
                  const Text("Bebidas")
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(217, 217, 217, 0.2),
                      ),
                    ),
                  ),
                  const Text("Salsas")
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
