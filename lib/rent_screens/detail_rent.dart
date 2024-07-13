import 'package:flutter/material.dart';
import '../database/database_rent.dart';
import '../database/database_client.dart';
import '../database/database_vehicle.dart';

class RentDetailScreen extends StatelessWidget {
  final int rentId;

  const RentDetailScreen({super.key, required this.rentId});

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
        title: const Text('Detail rent'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadRentDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Rent not found'));
          }

          final rent = snapshot.data!['rent'] as Rent;
          final client = snapshot.data!['client'] as Client;
          final vehicle = snapshot.data!['vehicle'] as Vehicle;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Client: ${client.name}',
                    style: const TextStyle(fontSize: 18)),
                Text('Phone number: ${client.phone}',
                    style: const TextStyle(fontSize: 18)),
                Text('CNPJ: ${client.cnpj}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Vehicle: ${vehicle.brand} ${vehicle.model}',
                    style: const TextStyle(fontSize: 18)),
                Text('Plate: ${vehicle.licensePlate}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Start date: ${rent.startDate}',
                    style: const TextStyle(fontSize: 18)),
                Text('End Date: ${rent.endDate}',
                    style: const TextStyle(fontSize: 18)),
                Text(
                    'Total rent value: R\$${(DateTime.parse(rent.endDate).
                    difference(DateTime.parse(rent.startDate)).
                    inDays * double.parse(vehicle.rentalCost)).
                    toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
