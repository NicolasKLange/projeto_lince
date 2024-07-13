import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../database/database_vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterVehicleScreen extends StatelessWidget {
  const RegisterVehicleScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => FIPEPROVIDERR(),
      child: Consumer<FIPEPROVIDERR>(builder: (_, state, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Register Vehicle'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: state.tipoSelecionado,
                      hint: const Text('Select type'),
                      items: state.tipos
                          .map<DropdownMenuItem<String>>((String tipo) {
                        return DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        state.tipoSelecionado = value;
                        state.Marcas();
                      },
                    ),
                    DropdownButton<MARCAS>(
                      value: state.marcaSelecionada,
                      hint: const Text('Select brand'),
                      items: state.marcas
                          .map<DropdownMenuItem<MARCAS>>((MARCAS marca) {
                        return DropdownMenuItem<MARCAS>(
                          value: marca,
                          child: Text(marca.name),
                        );
                      }).toList(),
                      onChanged: (MARCAS? value) {
                        state.marcaSelecionada = value;
                        state.carregarModelos();
                      },
                    ),
                    DropdownButton<MODELOS>(
                      value: state.modeloSelecionado,
                      hint: const Text('Select model'),
                      items: state.modelos
                          .map<DropdownMenuItem<MODELOS>>((MODELOS modelo) {
                        return DropdownMenuItem<MODELOS>(
                          value: modelo,
                          child: Text(modelo.name),
                        );
                      }).toList(),
                      onChanged: (MODELOS? value) {
                        state.modeloSelecionado = value;
                        state.notifyListeners();
                      },
                    ),
                    TextFormField(
                      controller: state.controllerPlaca,
                      decoration: const InputDecoration(labelText: 'Plate'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, insert the plate';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: state.controllerAnoFabricacao,

                      decoration: const InputDecoration(
                          labelText: 'Year of manufacture'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, insert the year of manufacture';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: state.controllerCustoDiaria,
                      decoration: const InputDecoration(
                          labelText: 'Daily rent cost'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, insert the daily rent cost';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.vehicleImages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.vehicleImages.length) {
                            return GestureDetector(
                              onTap: () {
                                state.getImage(ImageSource.camera);
                              },
                              child: Container(
                                width: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.add_a_photo, size: 50),
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                state.vehicleImages[index]!,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final vehicle = Vehicle(
                            brand: state.marcaSelecionada!.name,
                            model: state.modeloSelecionado!.name,
                            licensePlate: state.controllerPlaca.text,
                            year: state.controllerAnoFabricacao.text,
                            rentalCost: state.controllerCustoDiaria.text,
                            photos: state.vehicleImages
                                .map((file) => file?.path)
                                .where((path) => path != null)
                                .cast<String>()
                                .toList(),
                          );
                          await DatabaseVehicle.instance.create(vehicle);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vehicle successfully registered!'),
                            ),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MARCAS {
  String id;
  String name;

  MARCAS({required this.id, required this.name});

  static fromJson(Map<String, dynamic> json) {
    return MARCAS(id: json['code'], name: json['name']);
  }
}

class MODELOS {
  String id;
  String name;

  MODELOS({required this.id, required this.name});

  static fromJson(Map<String, dynamic> json) {
    return MODELOS(id: json['code'], name: json['name']);
  }
}

class FIPEPROVIDERR extends ChangeNotifier {
  List<String> tipos = ['cars', 'motorcycles', 'trucks'];
  String? tipoSelecionado;
  List<MARCAS> marcas = [];
  MARCAS? marcaSelecionada;
  List<MODELOS> modelos = [];
  MODELOS? modeloSelecionado;

  final _controllerTipoDoCarro = TextEditingController();
  final _controllerAnoFabricacao = TextEditingController();
  final _controllerCustoDiaria = TextEditingController();
  final _controllerPlaca = TextEditingController();
  List<File?> _vehicleImages = [];

  TextEditingController get controllerTipoDoCarro => _controllerTipoDoCarro;

  TextEditingController get controllerAnoFabricacao => _controllerAnoFabricacao;

  TextEditingController get controllerCustoDiaria => _controllerCustoDiaria;

  TextEditingController get controllerPlaca => _controllerPlaca;

  List<File?> get vehicleImages => _vehicleImages;

  Future<void> Marcas() async {
    if (tipoSelecionado != null) {
      marcaSelecionada = null;
      marcas = [];
      final response = await http.get(
        Uri.parse(
            'https://fipe.parallelum.com.br/api/v2/$tipoSelecionado/brands'),
      );
      final List<dynamic> data = jsonDecode(response.body);
      for (final it in data) {
        marcas.add(MARCAS.fromJson(it));
      }
      notifyListeners();
    }
  }

  Future<void> carregarModelos() async {
    if (marcaSelecionada != null) {
      modeloSelecionado = null;
      modelos = [];
      final response = await http.get(
        Uri.parse(
            'https://fipe.parallelum.com.br/api/v2/$tipoSelecionado/brands/'
            '${marcaSelecionada!.id}/models'),
      );
      final List<dynamic> data = jsonDecode(response.body);
      for (final it in data) {
        modelos.add(MODELOS.fromJson(it));
      }
      notifyListeners();
    }
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null && _vehicleImages.length < 6) {
      _vehicleImages.add(File(pickedFile.path));
      notifyListeners();
    }
  }
}
