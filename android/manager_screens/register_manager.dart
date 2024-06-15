import 'package:flutter/material.dart';

class RegisterManagerScreen extends StatelessWidget {
  const RegisterManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Gerente'),
      ),
      body: const Center(
        child: Text('Tela de Cadastro de Gerente'),
      ),
    );
  }
}