import 'package:flutter/material.dart';
import 'dart:io';
import '../database/database_rent.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';
/*
class DetailRentScreen extends StatelessWidget {
  final Rent rent;

  DetailRentScreen({Key? key, required this.rent}) : super(key: key);

  Future<Map<String, dynamic>> _getDetails() async {
    final client = await DatabaseClient().getClients();
    final vehicle = await DatabaseVehicle().readVehicle(rent.vehicleId);
    return {
      'client': client.firstWhere((element) => element.id == rent.clientId),
      'vehicle': vehicle,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Aluguel'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum detalhe encontrado'));
          } else {
            final details = snapshot.data!;
            final client = details['client'] as Client;
            final vehicle = details['vehicle'] as Vehicle;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Cliente: ${client.name}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Telefone: ${client.phone}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('CNPJ: ${client.cnpj}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Veículo: ${vehicle.brand} ${vehicle.model}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Placa: ${vehicle.licensePlate}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Ano: ${vehicle.year}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Custo da Diária: ${vehicle.rentalCost}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Data de Início: ${rent.startDate}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Data de Término: ${rent.endDate}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text('Custo Total: ${rent.totalCost}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    if (vehicle.photos != null && vehicle.photos!.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: vehicle.photos!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(vehicle.photos![index]),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
*/