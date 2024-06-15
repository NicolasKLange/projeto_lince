import 'package:flutter/material.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências do APP'),
      ),
      body: const Center(
        child: Text('Tela de Preferências do APP'),
      ),
    );
  }
}