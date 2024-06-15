import 'package:flutter/material.dart';
import '../database/database_manager.dart';
import 'detail_manager.dart';
import 'edit_manager.dart';

class CheckManagerScreen extends StatefulWidget {
  const CheckManagerScreen({super.key});

  @override
  CheckManagerScreenState createState() => CheckManagerScreenState();
}

class CheckManagerScreenState extends State<CheckManagerScreen> {
  late Future<List<Manager>> _managers;

  @override
  void initState() {
    super.initState();
    _managers = DatabaseManager().getManagers();
  }

  void _deleteManager(int id) async {
    await DatabaseManager().deleteManager(id);
    setState(() {
      _managers = DatabaseManager().getManagers();
    });
  }

  void _editManager(Manager manager) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditManagerScreen(manager: manager),
      ),
    );
    setState(() {
      _managers = DatabaseManager().getManagers();
    });
  }

  void _viewManagerDetails(Manager manager) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailManagerScreen(manager: manager),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Gerentes'),
      ),
      body: FutureBuilder<List<Manager>>(
        future: _managers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar gerentes'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum gerente cadastrado'));
          } else {
            final managers = snapshot.data!;
            return ListView.builder(
              itemCount: managers.length,
              itemBuilder: (context, index) {
                final manager = managers[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(manager.name),
                    subtitle: Text('CPF: ${manager.cpf}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editManager(manager),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteManager(manager.id!),
                        ),
                      ],
                    ),
                    onTap: () => _viewManagerDetails(manager),
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