import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocks/listar_mi_recetas_bloc.dart';
import '../widgets/tarjeta_receta_modelo_grande.widget.dart';

class MisRecetasBody extends StatefulWidget {
  const MisRecetasBody({super.key});

  @override
  State<MisRecetasBody> createState() => _MisRecetasBodyState();
}

class _MisRecetasBodyState extends State<MisRecetasBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListarMiRecetasBloc>(context).add(ListarMiRecetasEvent(userId: "", pagina: 1, cantidadPorPaguina: 20));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListarMiRecetasBloc, ListarMiRecetasState>(
      builder: (context, state) {
        if (state is ListarMiRecetasLoading) {
          return Text("Cargandoo");
        }
        if (state is ListarMiRecetasError) {
          return Text("error");
        }
        if (state is ListarMiRecetasSucces) {
          print(state.recetas);
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
                      itemCount: state.recetas.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final receta = state.recetas[index];
                        return Center(
                          child: TarjetaRecetaModeloGrande(receta: receta),
                        );
                      }))
            ],
          );
        }
        return Text("");
      },
      listener: (context, state) {},
    );
  }
}
