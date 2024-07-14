import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'client_screens/check_client.dart';
import 'client_screens/client.dart';
import 'client_screens/register_client.dart';
import 'manager_screens/check_manager.dart';
import 'manager_screens/manager.dart';
import 'manager_screens/register_manager.dart';
import 'rent_screens/check_rent.dart';
import 'rent_screens/register_rent.dart';
import 'rent_screens/rent.dart';
import 'screen/dashboard.dart';
import 'screen/login.dart';
import 'vehicle_screens/check_vehicle.dart';
import 'vehicle_screens/register_vehicle.dart';
import 'vehicle_screens/vehicle.dart';


void main() {
  runApp(const MyApp());
}
///Main class for MyApp
class MyApp extends StatelessWidget {
  ///Main class for MyApp
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SS Automóveis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
      },
    );
  }
}