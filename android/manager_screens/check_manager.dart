import 'package:flutter/material.dart';

class CheckManagerScreen extends StatelessWidget {
  const CheckManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Gerente'),
      ),
      body: const Center(
        child: Text('Tela de Consultar Gerentes'),
      ),
    );
  }
}