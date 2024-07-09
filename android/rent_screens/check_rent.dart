
import 'package:flutter/material.dart';

class CheckRentScreen extends StatelessWidget {
  const CheckRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Aluguel'),
      ),
      body: const Center(
        child: Text('Tela de Consultar Aluguel'),
      ),
    );
  }
}