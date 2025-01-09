import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextFormField extends StatelessWidget {
   FormTextFormField({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.focusNombreReceta,
    required this.nombreRecetaController,
    required this.tiempoDePreparacionController,
    required this.tiempoDePreparacionFocus,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final FocusNode focusNombreReceta;
  final TextEditingController nombreRecetaController;
  //LOGICA PARA TIEMPO DE PREPARACION
  final TextEditingController tiempoDePreparacionController;
  final FocusNode tiempoDePreparacionFocus;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                focusNode: focusNombreReceta,
                onTapOutside: (event) {
                  focusNombreReceta.unfocus();
                },
                controller: nombreRecetaController,
                decoration: InputDecoration(
                    labelText: "Nombre de la receta",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "por favor ingrese un nombre para la receta";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child:  Text("Tiempo de \npreparacion")),
                Expanded(
                    child: TextFormField(
                  focusNode: tiempoDePreparacionFocus,
                  controller: tiempoDePreparacionController,
                  decoration: InputDecoration(
                      labelText: "Nombre de la receta",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    print(value);
                  if (value == null || value.isEmpty) {
                    return "ingrese el tiempo ";
                  }
                },
                ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}
