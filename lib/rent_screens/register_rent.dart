import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';
import '../database/database_rent.dart';

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
  Client? _client;

  Future<void> _validateCnpj() async {
    final client = await DatabaseClient().getClientByCnpj(_cnpjController.text);
    setState(() {
      _isCnpjValid = client != null;
      _client = client;
    });
  }

  Future<void> _loadAvailableVehicles() async {
    final vehicles = await DatabaseVehicle.instance.readAllVehicles();
    setState(() {
      _availableVehicles = vehicles;
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

  Future<void> _registerRent() async {
    if (_formKey.currentState!.validate() && _selectedVehicle != null && _startDate != null && _endDate != null) {
      final rent = Rent(
        clientId: _client!.id!,
        vehicleId: _selectedVehicle!.id!,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      );
      await DatabaseRent.instance.create(rent);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered rent!')),
      );
      Navigator.of(context).pop();
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
        title: const Text('Register rent'),
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
                  decoration: const InputDecoration(labelText: 'Client CNPJ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pleas, insert client CNPJ';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _validateCnpj,
                  child: const Text('Validate CNPJ'),
                ),
                if (_isCnpjValid) ...[
                  DropdownButton<Vehicle>(
                    value: _selectedVehicle,
                    hint: const Text('Select vehicle'),
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
                    decoration: const InputDecoration(labelText: 'Start date'),
                    readOnly: true,
                    onTap: () => _pickDate(context, _startDateController, true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, insert start date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _endDateController,
                    decoration: const InputDecoration(labelText: 'End Date'),
                    readOnly: true,
                    onTap: () => _pickDate(context, _endDateController, false),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, insert end date';
                      }
                      return null;
                    },
                  ),
                  if (_startDate != null && _endDate != null) ...[
                    Text(
                      'Rent days: ${_endDate!.difference(_startDate!).inDays}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Total value: R\$${(_endDate!.difference(_startDate!).inDays * double.parse(_selectedVehicle!.rentalCost)).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: _registerRent,
                    child: const Text('Register rent'),
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