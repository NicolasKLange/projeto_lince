import 'package:flutter/material.dart';
import '../database/database_vehicle.dart';
import 'edit_vehicle.dart';
import 'detail_vehicle.dart';

class CheckVehicleScreen extends StatelessWidget {
  const CheckVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register vehicle'),
      ),
      body: FutureBuilder<List<Vehicle>>(
        future: DatabaseVehicle.instance.readAllVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No vehicles registered'));
          } else {
            final vehicles = snapshot.data!;
            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return ListTile(
                  title: Text('${vehicle.brand} ${vehicle.model}'),
                  subtitle: Text('Plate: ${vehicle.licensePlate}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailVehicleScreen
                          (vehicle: vehicle),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditVehicleScreen(vehicle: vehicle),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await DatabaseVehicle.instance.delete(vehicle.id!);
                          // Rebuild the widget to update the list
                          (context as Element).reassemble();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}