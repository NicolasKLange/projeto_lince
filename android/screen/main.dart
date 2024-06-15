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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/client': (context) => ClientScreen(),
        '/register-client': (context) => RegisterClientScreen(),
        '/check-client': (context) => CheckClientScreen(),
        '/manager': (context) => ManagerScreen(),
        '/register-manager': (context) => RegisterManagerScreen(),
        '/check-manager': (context) => CheckManagerScreen(),
        '/vehicle': (context) => VehicleScreen(),
        '/register-vehicle': (context) => RegisterVehicleScreen(),
        '/check-vehicle': (context) => CheckVehicleScreen(),
        '/rent': (context) => RentScreen(),
        '/register-rent': (context) => RegisterRentScreen(),
        '/check-rent': (context) => CheckRentScreen(),
        '/edit-profile': (context) => EditProfileScreen(),
        '/preferences': (context) => PreferencesScreen(),
      },
    );
  }
}