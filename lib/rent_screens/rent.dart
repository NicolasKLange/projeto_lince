import 'package:flutter/material.dart';

class RentScreen extends StatelessWidget {
  const RentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rent',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('lib/assets/logoSS.png'),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildDashboardButton(context, 'Register Rent',
                    Icons.calendar_month_rounded, '/register-rent'),
                _buildDashboardButton(context, 'Check Rent',
                    Icons.fact_check_outlined, '/check-rent'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardButton(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      color: const Color(0xFFD7D6D4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: Colors.black45, width: 5.0), // Borda
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
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
