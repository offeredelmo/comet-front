import 'package:flutter/material.dart';

class ShowDialogAgregarProcedimiento extends StatelessWidget {
  ShowDialogAgregarProcedimiento(
      {super.key,
      required this.focusNombreIngrediente,
      required this.agregarProcedimiento,
      required this.editarProcedimiento,
      required this.index});

  final FocusNode focusNombreIngrediente;
  final TextEditingController procediimientoController =
      TextEditingController();
  final Function(String) agregarProcedimiento;
  final Function(int, String) editarProcedimiento;
  final int index;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Procedimiento"),
        IconButton.filled(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Descripción del paso #${index + 1}",
                      style: TextStyle(fontSize: 19),
                    ),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          8, // Cambia este valor para ajustar el ancho
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TextFormField(
                        controller: procediimientoController,
                        focusNode: focusNombreIngrediente,
                        onTapOutside: (event) {
                          focusNombreIngrediente.unfocus();
                        },
                        decoration: InputDecoration(
                          labelText: "Texto largo",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignLabelWithHint: true,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines:
                            null, // Permite que el cuadro crezca dinámicamente
                        expands:
                            true, // Hace que el cuadro llene el espacio disponible
                        textAlign: TextAlign
                            .start, // Alinea el texto horizontalmente a la izquierda
                        textAlignVertical: TextAlignVertical
                            .top, // Alinea el texto verticalmente en la parte superior
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            agregarProcedimiento(procediimientoController.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Agregar")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Descartar")),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}
