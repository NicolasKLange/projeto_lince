import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';

class RegisterRentScreen extends StatefulWidget {
  const RegisterRentScreen({Key? key}) : super(key: key);

  @override
  _RegisterRentScreenState createState() => _RegisterRentScreenState();
}

class _RegisterRentScreenState extends State<RegisterRentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cnpjController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  Vehicle? _selectedVehicle;
  List<Vehicle> _availableVehicles = [];
  bool _isCnpjValid = false;

  Future<void> _validateCnpj() async {
    final client = await DatabaseClient().getClientByCnpj(_cnpjController.text);
    setState(() {
      _isCnpjValid = client != null;
    });
  }

  Future<void> _loadAvailableVehicles() async {
    final vehicles = await DatabaseVehicle.instance.readAllVehicles();
    // Aqui você pode adicionar lógica para filtrar veículos já alugados
    setState(() {
      _availableVehicles = vehicles; // Filtre veículos disponíveis
    });
  }

  Future<void> _pickDate(BuildContext context, TextEditingController controller, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAvailableVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Aluguel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _cnpjController,
                  decoration: const InputDecoration(labelText: 'CNPJ do Cliente'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o CNPJ';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _validateCnpj,
                  child: const Text('Validar CNPJ'),
                ),
                if (_isCnpjValid) ...[
                  DropdownButton<Vehicle>(
                    value: _selectedVehicle,
                    hint: const Text('Selecione o veículo'),
                    items: _availableVehicles.map<DropdownMenuItem<Vehicle>>((Vehicle vehicle) {
                      return DropdownMenuItem<Vehicle>(
                        value: vehicle,
                        child: Text('${vehicle.brand} ${vehicle.model}'),
                      );
                    }).toList(),
                    onChanged: (Vehicle? value) {
                      setState(() {
                        _selectedVehicle = value;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _startDateController,
                    decoration: const InputDecoration(labelText: 'Data de Início'),
                    readOnly: true,
                    onTap: () => _pickDate(context, _startDateController, true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data de início';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _endDateController,
                    decoration: const InputDecoration(labelText: 'Data de Término'),
                    readOnly: true,
                    onTap: () => _pickDate(context, _endDateController, false),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data de término';
                      }
                      return null;
                    },
                  ),
                  if (_startDate != null && _endDate != null) ...[
                    Text(
                      'Dias de aluguel: ${_endDate!.difference(_startDate!).inDays}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Valor total: R\$${(_endDate!.difference(_startDate!).inDays * double.parse(_selectedVehicle!.rentalCost)).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _selectedVehicle != null) {
                        // Salvar aluguel no banco de dados
                      }
                    },
                    child: const Text('Registrar Aluguel'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}