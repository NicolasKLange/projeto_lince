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
          _buildDashboardButton(context, 'Register manager', Icons.supervisor_account, '/register-manager'),
          _buildDashboardButton(context, 'Check manager', Icons.manage_search_rounded, '/check-manager'),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String title, IconData icon, String route) {
    return Card(
      color: const Color(0xFF69BBBF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: Color(0xFF126266), width: 5.0),  // Borda roxa
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: const Color(0xFF033D40),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF033D40),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}