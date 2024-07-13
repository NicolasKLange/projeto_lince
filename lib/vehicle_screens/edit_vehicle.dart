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
    final licensePlateController =
        TextEditingController(text: vehicle.licensePlate);
    final yearController = TextEditingController(text: vehicle.year);
    final rentalCostController =
        TextEditingController(text: vehicle.rentalCost);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vehicle'),
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
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert the brand';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert the model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: licensePlateController,
                  decoration: const InputDecoration(labelText: 'Plate'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert the plate';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: yearController,
                  decoration:
                      const InputDecoration(labelText: 'Year of manufacture'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert the year of manufacture';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: rentalCostController,
                  decoration:
                      const InputDecoration(labelText: 'Daily rental cost'),
                  keyboardType: const TextInputType.numberWithOptions
                    (decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert the daily rent cost';
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
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
