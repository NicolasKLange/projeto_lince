import 'package:flutter/material.dart';
import '../database/database_client.dart';
import 'detail_client.dart';
import 'edit_client.dart';

///Screen class check client
class CheckClientScreen extends StatefulWidget {
  ///Screen class check client
  const CheckClientScreen({super.key});

  @override
  CheckClientScreenState createState() => CheckClientScreenState();
}

///Screen class check client
class CheckClientScreenState extends State<CheckClientScreen> {
  late Future<List<Client>> _clients;

  @override
  void initState() {
    super.initState();
    _clients = DatabaseClient().getClients();
  }

  void _deleteClient(int id) async {
    await DatabaseClient().deleteClient(id);
    setState(() {
      _clients = DatabaseClient().getClients();
    });
  }

  void _editClient(Client client) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditClientScreen(client: client),
      ),
    );
    setState(() {
      _clients = DatabaseClient().getClients();
    });
  }

  void _viewClientDetails(Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailClientScreen(client: client),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Client'),
      ),
      body: FutureBuilder<List<Client>>(
        future: _clients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading clients...'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No registered client'));
          } else {
            final clients = snapshot.data!;
            return ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(client.name),
                    subtitle: Text('CNPJ: ${client.cnpj}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editClient(client),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteClient(client.id!),
                        ),
                      ],
                    ),
                    onTap: () => _viewClientDetails(client),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
