import 'package:flutter/material.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildDashboardButton(context, 'Register manager', '/register-manager'),
          _buildDashboardButton(context, 'Check manager', '/check-manager'),
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