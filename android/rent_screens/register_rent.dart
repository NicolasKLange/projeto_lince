import 'package:flutter/material.dart';

class RegisterRentScreen extends StatelessWidget {
  const RegisterRentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Aluguel'),
      ),
      body: const Center(
        child: Text('Tela de Cadastro de Aluguel'),
      ),
    );
  }
}