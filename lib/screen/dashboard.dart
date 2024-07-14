import 'package:flutter/material.dart';

///Dashboard screen class
class DashboardScreen extends StatelessWidget {
  ///Dashboard screen class
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
          _buildDashboardButton(context, 'Client', '/client'),
          _buildDashboardButton(context, 'Manager', '/manager'),
          _buildDashboardButton(context, 'Vehicle', '/vehicle'),
          _buildDashboardButton(context, 'Rent', '/rent'),
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