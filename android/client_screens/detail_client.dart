import 'package:flutter/material.dart';
import '../database/database_client.dart';

class DetailClientScreen extends StatelessWidget {
  final Client client;

  const DetailClientScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${client.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Telefone: ${client.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('CNPJ: ${client.cnpj}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Cidade: ${client.city}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Estado: ${client.state}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}