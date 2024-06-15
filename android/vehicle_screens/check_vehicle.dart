import 'package:flutter/material.dart';

class CheckVehicleScreen extends StatelessWidget {
  const CheckVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Veículos'),
      ),
      body: const Center(
        child: Text('Tela de Consultar Veículo'),
      ),
    );
  }
}