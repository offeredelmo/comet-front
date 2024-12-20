
import 'package:flutter/material.dart';

class FormTextFormField extends StatelessWidget {
  const FormTextFormField({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.focusNombreReceta, required this.nombreRecetaController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final FocusNode focusNombreReceta;
  final TextEditingController nombreRecetaController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            focusNode: focusNombreReceta,
            onTapOutside: (event) {
              focusNombreReceta.unfocus();
            },
            decoration: InputDecoration(
                labelText: "Nombre de la receta",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "por favor ingrese un nombre para la receta";
              }
            },
          ),
        ));
  }
}
