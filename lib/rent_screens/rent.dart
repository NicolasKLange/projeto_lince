import 'package:flutter/material.dart';

class RentScreen extends StatelessWidget {
  const RentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildDashboardButton(context, 'Register Rent', Icons.calendar_month_rounded, '/register-rent'),
          _buildDashboardButton(context, 'Check Rent', Icons.fact_check_outlined, '/check-rent'),
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