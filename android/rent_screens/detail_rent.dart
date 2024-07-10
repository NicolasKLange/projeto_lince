import 'package:flutter/material.dart';
import '../database/database_rent.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';

class RentDetailScreen extends StatelessWidget {
  final int rentId;

  const RentDetailScreen({Key? key, required this.rentId}) : super(key: key);

  Future<Map<String, dynamic>> _loadRentDetails() async {
    final rent = await DatabaseRent.instance.readRent(rentId);
    final client = await DatabaseClient().readClient(rent.clientId);
    final vehicle = await DatabaseVehicle.instance.readVehicle(rent.vehicleId);

    return {
      'rent': rent,
      'client': client,
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
        future: _loadRentDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar detalhes'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Aluguel não encontrado'));
          }

          final rent = snapshot.data!['rent'] as Rent;
          final client = snapshot.data!['client'] as Client;
          final vehicle = snapshot.data!['vehicle'] as Vehicle;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cliente: ${client.name}', style: const TextStyle(fontSize: 18)),
                Text('Telefone: ${client.phone}', style: const TextStyle(fontSize: 18)),
                Text('CNPJ: ${client.cnpj}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Veículo: ${vehicle.brand} ${vehicle.model}', style: const TextStyle(fontSize: 18)),
                Text('Placa: ${vehicle.licensePlate}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Data de Início: ${rent.startDate}', style: const TextStyle(fontSize: 18)),
                Text('Data de Término: ${rent.endDate}', style: const TextStyle(fontSize: 18)),
                Text('Valor Total: R\$${(DateTime.parse(rent.endDate).difference(DateTime.parse(rent.startDate)).inDays * double.parse(vehicle.rentalCost)).toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
