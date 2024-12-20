import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/form_text_form_field.widget.dart';
import '../widgets/seleccionar_imagen.widget.dart';
import '../widgets/show_dialog_agregar_procedimiento.widget.dart';

class AgregarReceta extends StatefulWidget {
  const AgregarReceta({super.key});

  @override
  State<AgregarReceta> createState() => _AgregarRecetaState();
}

class _AgregarRecetaState extends State<AgregarReceta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Evita que el teclado cubra los widgets
      appBar: AppBar(
        title: const Text("Agregar una nueva receta"),
      ),
      body: AgregarRecetasBody(),
    );
  }
}

class AgregarRecetasBody extends StatefulWidget {
  AgregarRecetasBody({
    super.key,
  });

  @override
  State<AgregarRecetasBody> createState() => _AgregarRecetasBodyState();
}

class _AgregarRecetasBodyState extends State<AgregarRecetasBody> {
  //sirve para controlar el FormTextFormField
  final _formKey = GlobalKey<FormState>();

  final focusNombreReceta = FocusNode();

  final TextEditingController nombreRecetaController = TextEditingController();

  //
  late File image = File(''); // Archivo vacío como valor inicial


  //Sirve para controlar el form de agregar ingredientes
  final _formKeyIngredient = GlobalKey<FormState>();

  final focusNombreIngrediente = FocusNode();

  final focusCantidadIngrediente = FocusNode();

  final focusMedida = FocusNode();

  final TextEditingController ingredienteController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController MedidaController = TextEditingController();

  //eliminar cuando se cree la entidad y remplazarlo por una list de tipo ingrediente
  final List<Map<String, dynamic>> ejemploIngredfientes = [
    {"nombre": "arina", "cantidad": 2, "medida": "kilo"},
    {"nombre": "huevo", "cantidad": 2, "medida": "pieza"},
    {"nombre": "azucar", "cantidad": 2, "medida": "kilo"},
    {"nombre": "mantequilla", "cantidad": 2, "medida": "kilo"},
  ];
  late String cantidad = "kilo";
  void agregarIngrediente() {
    if (_formKeyIngredient.currentState!.validate()) {
      final nombreIngrediente = ingredienteController.text;
      final cantidad = cantidadController.text;
      final medida = cantidadController.text;
      final Map<String, dynamic> nuevoIngrediente = {
        "nombre": nombreIngrediente,
        "cantidad": cantidad,
        "medida": medida,
      };
      setState(() {
        ejemploIngredfientes.add(nuevoIngrediente);
      });

      print("Nombre del ingrediente: $nombreIngrediente");
      print("Cantidad: $cantidad");
      print("Medida: $cantidad");

      // Puedes limpiar el formulario si es necesario
      _formKeyIngredient.currentState!.reset();
    }
  }

  //logica para la lista de procedimientos
  final TextEditingController controllerActualizar = TextEditingController();
  final List<String> procedimientos = [
    "trucu truc truc tuercaosflasdhfajshdbfjhkasbdjhfbakjhsdbfjkhabsdjhbfjkhasbdjkhfbasjkdhbfkjhasbdjkhfbajhksd",
    "alkhdflkuajshdkfjhaskjdhflkajshdkfjhasldjkhflkjashdlfkjhasdlkjhflkjashdflkjhasdjkhfkjasdhflkjhasdlkjhfalkjsdh"
  ];
  void eliminarProcedimiento(int index) {
    setState(() {
      procedimientos.removeAt(index);
    });
  }

  void agregarProcedimiento(String procedimiento) {
    setState(() {
      procedimientos.add(procedimiento);
    });
  }

  void actualizarProcedimiento(int index, String procedimiento) {
    setState(() {
      procedimientos[index] = procedimiento;
    });
  }

  //logica para las etiquetas
  final List<String> etiquetas = ["desayuno", "cena"];
  void agregarEtiqueta(String etiqueta) {
    setState(() {
      etiquetas.add(etiqueta);
    });
  }

  void eliminarEtiqueta(int index) {
    setState(() {
      etiquetas.removeAt(index);
    });
  }

void agregarReceta() {
  if (_formKey.currentState!.validate()) {
    print(nombreRecetaController.text);
    print(image);
    print(procedimientos);
    print(ejemploIngredfientes);
    print(etiquetas);
  }
}
  //funcion para guardar y contruir la receta


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              FormTextFormField(
                  formKey: _formKey, focusNombreReceta: focusNombreReceta, nombreRecetaController: nombreRecetaController,),
              const SizedBox(
                height: 6,
              ),
              ImagePickerExample(image: image,),
              const Divider(
                height: 30,
                thickness: 1,
                indent: 0,
                color: Colors.black54,
              ),
              ShowDialogAgregarProcedimiento(
                focusNombreIngrediente: focusNombreIngrediente,
                agregarProcedimiento: agregarProcedimiento,
                editarProcedimiento: actualizarProcedimiento,
                index: procedimientos.length,
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: procedimientos.length,
                  itemBuilder: (context, index) {
                    final procedimiento = procedimientos[index];
                    return ExpansionTile(
                      title: Text("Procedimiento #${index + 1}"),
                      children: [
                        Column(
                          children: [
                            Text("${procedimiento}"),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      eliminarProcedimiento(index);
                                    },
                                    child: const Text("Eliminar")),
                                TextButton(
                                    onPressed: () {
                                      showDialogEditarProcedimiento(
                                          context, index);
                                    },
                                    child: const Text("Editar")),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ModalAgregarIngrediente(context);
                },
                child: const Text("Agregar Ingrediente"),
              ),
              const SizedBox(
                height: 20,
              ),
              AdministrarEtiquetasWidget(
                agregarEtiquetas: agregarEtiqueta,
                eliminarEtiqueta: eliminarEtiqueta,
                etiquetas: etiquetas,
              ),
                 const SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed: (){
                agregarReceta();
              }, child: Text("Agregar Receta")),
                 const SizedBox(
                height: 50,
              ),
            ],
            
            
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDialogEditarProcedimiento(
      BuildContext context, int index) {
    return showDialog(
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
              controller: controllerActualizar,
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
              maxLines: null, // Permite que el cuadro crezca dinámicamente
              expands: true, // Hace que el cuadro llene el espacio disponible
              textAlign: TextAlign
                  .start, // Alinea el texto horizontalmente a la izquierda
              textAlignVertical: TextAlignVertical
                  .top, // Alinea el texto verticalmente en la parte superior
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    actualizarProcedimiento(index, controllerActualizar.text);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Actualizar")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Descartar")),
          ],
        );
      },
    );
  }

  Future<dynamic> ModalAgregarIngrediente(BuildContext context) {
    final List<DropdownMenuEntry<String>> opciones = [
      DropdownMenuEntry(value: 'kilo', label: 'Kilo'),
      DropdownMenuEntry(value: 'gramo', label: 'Gramo'),
      DropdownMenuEntry(value: 'litro', label: 'Litro'),
      DropdownMenuEntry(value: 'mililitro', label: 'Mililitro'),
      DropdownMenuEntry(value: 'pieza', label: 'Pieza'),
      DropdownMenuEntry(value: 'taza', label: 'Taza'),
      DropdownMenuEntry(value: 'cucharada', label: 'Cucharada'),
      DropdownMenuEntry(value: 'pizca', label: 'Pizca'),
      DropdownMenuEntry(value: 'algusto', label: 'Al gusto'),
      DropdownMenuEntry(value: 'cuarto', label: 'cuarto'),
      DropdownMenuEntry(value: 'mitad', label: 'mitad'),
    ];

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Permite usar más espacio en la pantalla
        builder: (BuildContext content) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.width * 1.6,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.94,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                          key: _formKeyIngredient,
                          child: Column(
                            children: [
                              TextFormField(
                                focusNode: focusNombreIngrediente,
                                onTapOutside: (event) {
                                  focusNombreIngrediente.unfocus();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Por favor, ingresa el nombre del ingrediente";
                                  }
                                  return null; // Entrada válida
                                },
                                controller: ingredienteController,
                                decoration: InputDecoration(
                                    labelText: "Ingrediente",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: focusCantidadIngrediente,
                                      controller: cantidadController,
                                      onTapOutside: (event) {
                                        focusCantidadIngrediente.unfocus();
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "ingrese una cantidad";
                                        }
                                        return null; // Entrada válida
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          labelText: "Cantidad",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      //cambiar por un dropdown
                                      child: DropdownMenu(
                                    dropdownMenuEntries: opciones,
                                    label: Text("Medida"),
                                    initialSelection: "kilo",
                                    onSelected: (value) {
                                      cantidad = value!;
                                      print('Seleccionado: $value');
                                    },
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      agregarIngrediente();
                                    });
                                    setState(() {});
                                  },
                                  child: const Text("Agregar ingrediente"))
                            ],
                          )),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Text("Ingredientes "),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: const Text("Cantidad "),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: const Text("Medida "),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: ejemploIngredfientes.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text("ingrediente "),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text("catidad "),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text("medida "),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

class AdministrarEtiquetasWidget extends StatelessWidget {
  AdministrarEtiquetasWidget({
    super.key,
    required this.agregarEtiquetas,
    required this.eliminarEtiqueta,
    required this.etiquetas,
  });
  final Function(String) agregarEtiquetas;
  final Function(int) eliminarEtiqueta;
  final List<String> etiquetas;
  final TextEditingController etiquetaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [Text("Etiquetas")],
        ),
        const SizedBox(height: 10), // Espacio entre el título y el formulario
        Row(
          children: [
            Expanded(
              flex: 7, // El TextFormField ocupa el 70% del espacio
              child: TextFormField(
                controller: etiquetaController,
                decoration: InputDecoration(
                  labelText: "Etiqueta",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10), // Espacio entre el campo y el botón
            Expanded(
              flex: 3, // El botón ocupa el 30% del espacio
              child: ElevatedButton(
                onPressed: () {
                  if (etiquetaController.text.isEmpty ||
                      etiquetaController.text == "") {
                  } else {
                    agregarEtiquetas(etiquetaController.text);
                  }
                },
                child: const Text("Agregar"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 200,
          child: Wrap(
            spacing: 4.0,
            children: etiquetas.asMap().entries.map((entry) {
              return Chip(
                label: Text(
                  '${entry.value}', // Muestra el índice y el valor
                  style: const TextStyle(fontSize: 12),
                ),
                onDeleted: () {
                  eliminarEtiqueta(entry.key);
                },
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
