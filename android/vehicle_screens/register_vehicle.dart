import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class RegisterVehicleScreen extends StatelessWidget {
  const RegisterVehicleScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final olho = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => FIPEPROVIDERR(),
      child: Consumer<FIPEPROVIDERR>(builder: (_, state, __) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Fipe'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: olho,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: state.tipoSelecionado,
                        hint: const Text('Selecione o tipo'),
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
                        hint: const Text('Selecione a marca'),
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
                        hint: const Text('Selecione o modelo'),
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
                        controller: state.controllerAnoFabricacao,
                        decoration: const InputDecoration(labelText: 'Ano de Fabricação'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: state.controllerCustoDiaria,
                        decoration: const InputDecoration(labelText: 'Custo da Diária de Aluguel'),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (olho.currentState!.validate()) {
                            state.saveVehicle();
                          }
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
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


  final _controllerAnoFabricacao = TextEditingController();
  final _controllerCustoDiaria = TextEditingController();


  TextEditingController get controllerAnoFabricacao => _controllerAnoFabricacao;
  TextEditingController get controllerCustoDiaria => _controllerCustoDiaria;


  Future<void> Marcas() async {
    if (tipoSelecionado != null) {
      marcaSelecionada = null;
      marcas = [];
      final response = await http.get(
        Uri.parse('https://fipe.parallelum.com.br/api/v2/$tipoSelecionado/brands'),
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
            'https://fipe.parallelum.com.br/api/v2/$tipoSelecionado/brands/${marcaSelecionada!.id}/models'),
      );
      final List<dynamic> data = jsonDecode(response.body);
      for (final it in data) {
        modelos.add(MODELOS.fromJson(it));
      }
      notifyListeners();
    }
  }


  void saveVehicle() {
    // Aqui você pode adicionar a lógica para salvar o veículo no banco de dados
    print('Veículo salvo:');
    print('Tipo: $tipoSelecionado');
    print('Marca: ${marcaSelecionada?.name}');
    print('Modelo: ${modeloSelecionado?.name}');
    print('Ano de Fabricação: ${_controllerAnoFabricacao.text}');
    print('Custo da Diária: ${_controllerCustoDiaria.text}');
  }
}

