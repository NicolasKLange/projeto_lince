import 'dart:io';
import 'package:flutter/material.dart';
import '../database/database_vehicle.dart';

class DetailVehicleScreen extends StatelessWidget {
  final Vehicle vehicle;

  DetailVehicleScreen({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Marca: ${vehicle.brand}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Modelo: ${vehicle.model}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Placa: ${vehicle.licensePlate}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Ano de Fabricação: ${vehicle.year}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Custo da Diária de Aluguel: ${vehicle.rentalCost}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            if (vehicle.photo != null && vehicle.photo!.isNotEmpty)
              Image.file(
                File(vehicle.photo!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}