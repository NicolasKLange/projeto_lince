import 'package:flutter/material.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildDashboardButton(context, 'Register Vehicle', '/register-vehicle'),
          _buildDashboardButton(context, 'Check Vehicle', '/check-vehicle'),
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