import 'package:flutter/material.dart';
import '../database/database_client.dart';

class DetailClientScreen extends StatelessWidget {
  final Client client;

  DetailClientScreen({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${client.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Telefone: ${client.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('CNPJ: ${client.cnpj}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Cidade: ${client.city}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Estado: ${client.state}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}