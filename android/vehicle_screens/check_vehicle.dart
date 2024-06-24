import 'package:flutter/material.dart';
import '../database/database_vehicle.dart';
import 'edit_vehicle.dart';

class CheckVehicleScreen extends StatelessWidget {
  const CheckVehicleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos Cadastrados'),
      ),
      body: FutureBuilder<List<Vehicle>>(
        future: DatabaseVehicle.instance.readAllVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum veículo cadastrado'));
          } else {
            final vehicles = snapshot.data!;
            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return ListTile(
                  title: Text('${vehicle.brand} ${vehicle.model}'),
                  subtitle: Text('Placa: ${vehicle.licensePlate}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditVehicleScreen(vehicle: vehicle),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
