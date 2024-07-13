import 'package:flutter/material.dart';
import '../database/database_manager.dart';

class DetailManagerScreen extends StatelessWidget {
  final Manager manager;

  const DetailManagerScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${manager.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Phone number: ${manager.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('CPF: ${manager.cpf}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('State: ${manager.state}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('City: ${manager.city}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Commission: ${manager.comission}%', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}