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
        title: const Text('Detail Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Brand: ${vehicle.brand}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Model: ${vehicle.model}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Plate: ${vehicle.licensePlate}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Year of manufacture: ${vehicle.year}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Daily rent cost: ${vehicle.rentalCost}',
                  style: const TextStyle(fontSize: 18)),
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
      ),
    );
  }
}