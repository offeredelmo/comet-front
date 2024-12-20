import 'package:flutter/material.dart';

class MisIngredientes extends StatefulWidget {
  const MisIngredientes({super.key});

  @override
  State<MisIngredientes> createState() => _MisIngredientesState();
}

class _MisIngredientesState extends State<MisIngredientes> {
  late List<String> ingredientes = [
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga",
    "pollo",
    "huevo",
    "lechuga"
  ];
  final TextEditingController ingredienteController = TextEditingController();
  final FocusNode focusIngrediente = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void agregarIngrediente(String ingrediente) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        ingredientes.add(ingrediente);
        ingredienteController.clear();
      });
    }
  }

  void eliminarIngrediente(int index) {
    setState(() {
      ingredientes.removeAt(index); // Elimina el ingrediente
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Recuerda añadir los ingredientes que puedas conseguir cerca de tu zona para crear recetas basadas en los alimentos que tienes disponibles o que puedes obtener fácilmente.",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value == "") {
                        return "ingresa un ingrediente";
                      }
                      return null;
                    },
                    controller: ingredienteController,
                    focusNode: focusIngrediente,
                    onTapOutside: (event) {
                      focusIngrediente.unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: "Nombre del ingrediente",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  width: 10), // Espacio entre el TextFormField y el botón
              FloatingActionButton(
                onPressed: () {
                  agregarIngrediente(ingredienteController.text);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: ingredientes.length, // Usa la longitud de ingredientes
            itemBuilder: (context, index) {
              // Accede correctamente a los ingredientes
              String ingrediente = ingredientes[index];
              return ListTile(
                dense: false,
                title: Text(ingrediente), // Muestra el nombre del ingrediente
                trailing: IconButton(
                  onPressed: () {
                    eliminarIngrediente(index); // Elimina el ingrediente
                  },
                  icon: const Icon(Icons.delete_outlined),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
