import 'package:flutter/material.dart';
import '../client_screens/check_client.dart';
import '../client_screens/client.dart';
import '../client_screens/register_client.dart';
import '../manager_screens/check_manager.dart';
import '../manager_screens/manager.dart';
import '../manager_screens/register_manager.dart';
import '../rent_screens/check_rent.dart';
import '../rent_screens/register_rent.dart';
import '../rent_screens/rent.dart';
import '../vehicle_screens/check_vehicle.dart';
import '../vehicle_screens/register_vehicle.dart';
import '../vehicle_screens/vehicle.dart';
import 'dashboard.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/client': (context) => const ClientScreen(),
        '/register-client': (context) => const RegisterClientScreen(),
        '/check-client': (context) => const CheckClientScreen(),
        '/manager': (context) => const ManagerScreen(),
        '/register-manager': (context) => const RegisterManagerScreen(),
        '/check-manager': (context) => const CheckManagerScreen(),
        '/vehicle': (context) => const VehicleScreen(),
        '/register-vehicle': (context) => const RegisterVehicleScreen(),
        '/check-vehicle': (context) => const CheckVehicleScreen(),
        '/rent': (context) => const RentScreen(),
        '/register-rent': (context) => const RegisterRentScreen(),
        '/check-rent': (context) => const CheckRentScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/preferences': (context) => const PreferencesScreen(),
      },
    );
  }
}
