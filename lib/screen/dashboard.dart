import 'package:flutter/material.dart';

/// Dashboard screen class
class DashboardScreen extends StatelessWidget {
  /// Constructor for DashboardScreen
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildDashboardButton(context, 'Client', Icons.person, '/client'),
          _buildDashboardButton(context, 'Manager', Icons.business, '/manager'),
          _buildDashboardButton(context, 'Vehicle', Icons.directions_car, '/vehicle'),
          _buildDashboardButton(context, 'Rent', Icons.calendar_month_rounded, '/rent'),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(BuildContext context, String title, IconData icon, String route) {
    return Card(
      color: Color(0xFF69BBBF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Color(0xFF126266), width: 5.0),  // Borda roxa
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
              color: Color(0xFF033D40),
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
