import 'package:flutter/material.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';
import '../database/database_rent.dart';

class CheckRentScreen extends StatelessWidget {
  const CheckRentScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getRentDetails(Rent rent) async {
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
        title: const Text('Consultar Aluguéis'),
      ),
      body: FutureBuilder<List<Rent>>(
        future: DatabaseRent.instance.readAllRents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum aluguel realizado'));
          }

          final rents = snapshot.data!;
          return ListView.builder(
            itemCount: rents.length,
            itemBuilder: (context, index) {
              return FutureBuilder<Map<String, dynamic>>(
                future: _getRentDetails(rents[index]),
                builder: (context, rentDetailsSnapshot) {
                  if (rentDetailsSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Carregando...'),
                    );
                  } else if (rentDetailsSnapshot.hasError) {
                    return ListTile(
                      title: Text('Erro: ${rentDetailsSnapshot.error}'),
                    );
                  } else if (!rentDetailsSnapshot.hasData) {
                    return const ListTile(
                      title: Text('Dados não encontrados'),
                    );
                  }

                  final details = rentDetailsSnapshot.data!;
                  final client = details['client'] as Client;
                  final vehicle = details['vehicle'] as Vehicle;
                  final rent = details['rent'] as Rent;

                  return ListTile(
                    title: Text('Cliente: ${client.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefone: ${client.phone}'),
                        Text('CNPJ: ${client.cnpj}'),
                        Text('Veículo: ${vehicle.brand} ${vehicle.model} (${vehicle.licensePlate})'),
                        Text('Período: ${rent.startDate} - ${rent.endDate}'),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
