import 'package:flutter/material.dart';
import '../database/database_rent.dart';
/*
class EditRentScreen extends StatefulWidget {
  final Rent rent;

  EditRentScreen({Key? key, required this.rent}) : super(key: key);

  @override
  _EditRentScreenState createState() => _EditRentScreenState();
}

class _EditRentScreenState extends State<EditRentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _totalCostController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController(text: widget.rent.startDate);
    _endDateController = TextEditingController(text: widget.rent.endDate);
    _totalCostController = TextEditingController(text: widget.rent.totalCost.toString());
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _totalCostController.dispose();
    super.dispose();
  }

  Future<void> _updateRent() async {
    if (_formKey.currentState!.validate()) {
      final updatedRent = Rent(
        id: widget.rent.id,
        clientId: widget.rent.clientId,
        vehicleId: widget.rent.vehicleId,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        totalCost: double.parse(_totalCostController.text),
      );
      await DatabaseRent().updateRent(updatedRent);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Aluguel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Data de Início'),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de término';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalCostController,
                decoration: const InputDecoration(labelText: 'Custo Total'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o custo total';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateRent,
                child: const Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/