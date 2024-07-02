import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildDashboardButton(context, 'Clientes', '/client'),
          _buildDashboardButton(context, 'Gerentes', '/manager'),
          _buildDashboardButton(context, 'Veículos', '/vehicle'),
          _buildDashboardButton(context, 'Aluguéis', '/rent'),
          _buildDashboardButton(context, 'Editar Perfil', '/edit-profile'),
          _buildDashboardButton(context, 'Preferências', '/preferences'),
          _buildDashboardButton(context, 'Imagem', '/imagens'),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String title, String route) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}