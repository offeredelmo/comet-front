import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocks/buscador_receta_bloc.dart';
import '../blocks/editar_receta_bloc.dart';
import '../widgets/tarjeta_receta_modelo_pequeño.widget.dart';

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Botón que aparece a la izquierda (por ejemplo, el ícono de "atrás")
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados finales de la búsqueda}
    print("holaaaa");
    BlocProvider.of<BuscadorRecetaBloc>(context)
        .add(BuscarRecetaEvent(text: query));
    return BlocBuilder<BuscadorRecetaBloc, BuscadorState>(
      builder: (context, state) {
        if (state is BuscadorLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BuscadorError) {
          return Text("A ocurrido un error intenta mas tarde");
        }

        if (state is BuscadorSucces) {
          final recetas = state.listRecetaEntity;
          print(recetas.length);
          if (recetas.isEmpty) {
            return const Center(
              child: Text("No se encontraron resultados."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(7),
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TarjetaRecetaModeloPequeno(),
                      ),
                      const SizedBox(width: 5),
                      // Asegúrate de que no excedas el tamaño de la lista
                      // Al mostrar dos elementos por fila, podrías necesitar manejar índices impares
                      if (index + 1 < recetas.length)
                        Expanded(
                          child: TarjetaRecetaModeloPequeno(),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              );
            },
          );
        }

        return Text("a ocurrido un error inesperado");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final queryText = query; // Lo que el usuario va escribiendo
    return ListView(
      children: [
        ListTile(
          onTap: () {
            print(queryText);
          },
        ),
        // ...
      ],
    );
  }
}
