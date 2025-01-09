import 'dart:io';

import 'package:comet/core/recetas/domain/ingrdiente.entity.dart';
import 'package:comet/core/recetas/domain/receta.entity.dart';
import 'package:comet/core/recetas/presentation/blocks/agregar_receta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/form_text_form_field.widget.dart';
import '../widgets/seleccionar_imagen.widget.dart';
import '../widgets/show_dialog_agregar_procedimiento.widget.dart';

class ActualizarReceta extends StatefulWidget {
  final RecetaEntity receta;

  const ActualizarReceta({super.key, required this.receta});

  @override
  State<ActualizarReceta> createState() => _ActualizarRecetaState();
}

class _ActualizarRecetaState extends State<ActualizarReceta> {
  late RecetaEntity receta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Evita que el teclado cubra los widgets
      appBar: AppBar(
        title: const Text("Agregar una nueva receta"),
      ),
      body: ActualizarRecetaBody(receta: widget.receta),
    );
  }
}

class ActualizarRecetaBody extends StatefulWidget {
  final RecetaEntity receta;

  const ActualizarRecetaBody({
    super.key,
    required this.receta,
  });

  @override
  State<ActualizarRecetaBody> createState() => _ActualizarRecetaBodyState();
}

class _ActualizarRecetaBodyState extends State<ActualizarRecetaBody> {
  //sirve para controlar el FormTextFormField
  final _formKey = GlobalKey<FormState>();

  final focusNombreReceta = FocusNode();

  final TextEditingController nombreRecetaController =
      TextEditingController(); // se debe de inicializar

  //
  late File image = File(''); // Archivo vacío como valor inicial
  late String? imgUrl;

  void setPickedImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  //Sirve para controlar el form de agregar ingredientes
  final _formKeyIngredient = GlobalKey<FormState>();

  final focusNombreIngrediente = FocusNode();

  final focusCantidadIngrediente = FocusNode();

  final focusMedida = FocusNode();

  final TextEditingController ingredienteController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController medidaController = TextEditingController();

  //eliminar cuando se cree la entidad y remplazarlo por una list de tipo ingrediente
  List<IngredienteEntity> ingredientes =
      []; // se debe de inicializart con los ingredientes de la receta
  late String medida = "kilo";
  void agregarIngrediente() {
    if (_formKeyIngredient.currentState!.validate()) {
      final nombreIngrediente = ingredienteController.text;
      final cantidad = double.tryParse(cantidadController.text) ?? 0.0;
      final nuevoIngrediente = new IngredienteEntity(
          nombre: nombreIngrediente, cantidad: cantidad, medida: medida);
      setState(() {
        ingredientes.add(nuevoIngrediente);
      });

      print("Nombre del ingrediente: $nombreIngrediente");
      print("Cantidad: $cantidad");
      print("Medida: $medida");

      // Puedes limpiar el formulario si es necesario
      _formKeyIngredient.currentState!.reset();
    }
  }

  //logica para la lista de procedimientos
  final TextEditingController controllerActualizar = TextEditingController();
  List<String> procedimientos =
      []; // se debe de inicializart con los ingredientes de la receta
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
  List<String> etiquetas = ["desayuno", "cena"];
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
      setState(() {});
      final newReceta = new RecetaEntity(
        title: nombreRecetaController.text,
        preparation: procedimientos,
        ingredients: ingredientes,
        imgfile: image,
        timePreparationInMinutes: int.parse(tiempoDePreparacionController.text),
        userId:
            "675e0640d6b7a3ae20ccfcc3", //es necesario obtener el id del usuario
        tags: etiquetas,
      );
      BlocProvider.of<AgregarRecetaBloc>(context)
          .add(AgregarRecetaEvent(recetaEntity: newReceta));
    }
  }

  void eliminarIngrediente(int index) {
    setState(() {
      ingredientes.removeAt(index);
    });
  }

  //LOGICA PARA TIEMPO DE PREPARACION
  final TextEditingController tiempoDePreparacionController =
      TextEditingController();
  final FocusNode tiempoDePreparacionFocus = FocusNode();

  //funcion para guardar y contruir la receta
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.receta.title);
    print(widget.receta.imgUrl);
    nombreRecetaController.text = widget.receta.title;
    ingredientes = widget.receta.ingredients;
    procedimientos = widget.receta.preparation;
    etiquetas = widget.receta.tags;
    tiempoDePreparacionController.text =
        "${widget.receta.timePreparationInMinutes}";
    if (widget.receta.imgUrl != null) {
      print("Pos resulta que si hay pa");
      imgUrl = widget.receta.imgUrl!;
    } else {
      print("holaaaa no hay imagen y me igualo a nadota");
      imgUrl = null;
      // asignar una imagen local o otra url depende despues lo veremos
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgregarRecetaBloc, AgregarRecetaState>(
        listener: (context, state) {
          if (state is AgregarRecetaLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Agregando Producto ....."),
                backgroundColor: Colors.grey,
              ),
            );
          }
          if (state is AgregarRecetaError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("A ocurrido un error al agregar la nueva receta"),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AgregarRecetaSucces) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("La receta se ha agregado exitosamente."),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  FormTextFormField(
                    formKey: _formKey,
                    focusNombreReceta: focusNombreReceta,
                    nombreRecetaController: nombreRecetaController,
                    tiempoDePreparacionController:
                        tiempoDePreparacionController,
                    tiempoDePreparacionFocus: tiempoDePreparacionFocus,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ImagePickerEdit(
                    onImageSelected: setPickedImage,
                    urlImage: imgUrl,
                  ),
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
                  ElevatedButton(
                      onPressed: () {
                        agregarReceta();
                      },
                      child: Text("Agregar Receta")),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));
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
      DropdownMenuEntry(value: 'kilos', label: 'Kilo'),
      DropdownMenuEntry(value: 'gramo', label: 'Gramo'),
      DropdownMenuEntry(value: 'litro', label: 'Litro'),
      DropdownMenuEntry(value: 'mililitro', label: 'Mililitro'),
      DropdownMenuEntry(value: 'pieza', label: 'Pieza'),
      DropdownMenuEntry(value: 'taza', label: 'Taza'),
      DropdownMenuEntry(value: 'cucharada', label: 'Cucharada'),
      DropdownMenuEntry(value: 'cucharadita', label: 'Cucharaditas'),
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
                                      medida = value!;
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: const Text("Medida "),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: ingredientes.length,
                          itemBuilder: (context, index) {
                            final ingrediente = ingredientes[index];
                            return Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(ingrediente.nombre),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text("${ingrediente.cantidad}"),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Text(ingrediente.medida),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            eliminarIngrediente(index);
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.delete_outline_rounded)))
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
