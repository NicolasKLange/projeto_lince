
import 'package:flutter/material.dart';
import '../database/database_vehicle.dart';

class EditVehicleScreen extends StatelessWidget {
  final Vehicle vehicle;

  EditVehicleScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final brandController = TextEditingController(text: vehicle.brand);
    final modelController = TextEditingController(text: vehicle.model);
    final licensePlateController = TextEditingController(text: vehicle.licensePlate);
    final yearController = TextEditingController(text: vehicle.year);
    final rentalCostController = TextEditingController(text: vehicle.rentalCost);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: brandController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a marca';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: modelController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o modelo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: licensePlateController,
                  decoration: const InputDecoration(labelText: 'Placa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a placa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Ano de Fabricação'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o ano de fabricação';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: rentalCostController,
                  decoration: const InputDecoration(labelText: 'Custo da Diária de Aluguel'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o custo da diária de aluguel';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final updatedVehicle = vehicle.copyWith(
                        brand: brandController.text,
                        model: modelController.text,
                        licensePlate: licensePlateController.text,
                        year: yearController.text,
                        rentalCost: rentalCostController.text,
                      );

                      await DatabaseVehicle.instance.update(updatedVehicle);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}