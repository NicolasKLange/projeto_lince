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
          _buildDashboardButton(context, 'Register Vehicle', Icons.directions_car_outlined, '/register-vehicle'),
          _buildDashboardButton(context, 'Check Vehicle', Icons.manage_search_rounded, '/check-vehicle'),
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