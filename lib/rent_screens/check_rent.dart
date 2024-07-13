import 'package:flutter/material.dart';
import '../database/database_rent.dart';
import 'detail_rent.dart';
import 'edit_rent.dart';

class CheckRentScreen extends StatefulWidget {
  const CheckRentScreen({Key? key}) : super(key: key);

  @override
  _CheckRentScreenState createState() => _CheckRentScreenState();
}

class _CheckRentScreenState extends State<CheckRentScreen> {
  List<Rent> _rents = [];

  Future<void> _loadRents() async {
    final rents = await DatabaseRent.instance.readAllRents();
    setState(() {
      _rents = rents;
    });
  }

  Future<void> _deleteRent(int id) async {
    await DatabaseRent.instance.delete(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully deleted rent!')),
    );
    _loadRents();
  }

  @override
  void initState() {
    super.initState();
    _loadRents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check rent'),
      ),
      body: ListView.builder(
        itemCount: _rents.length,
        itemBuilder: (context, index) {
          final rent = _rents[index];
          return ListTile(
            title: Text('Client: ${rent.clientId}, Vehicle: ${rent.vehicleId}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RentDetailScreen(rentId: rent.id!),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRentScreen(rent: rent),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteRent(rent.id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
