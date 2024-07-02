import 'package:flutter/material.dart';
import 'dart:io';
import '../database/database_imagem.dart';

class VerifyPhotosScreen extends StatelessWidget {
  const VerifyPhotosScreen({super.key});

  Future<List<Map<String, dynamic>>> _fetchVehicles() async {
    return await DatabaseImagem().getVeiculos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Fotos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchVehicles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final vehicles = snapshot.data!;
          if (vehicles.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado.'));
          }

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              final imagePaths = (vehicle['imagens'] as String).split(',');

              return Card(
                child: ListTile(
                  title: Text(vehicle['nome']),
                  subtitle: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: imagePaths.map((path) {
                      return Image.file(
                        File(path),
                        width: 50,
                        height: 50,
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
