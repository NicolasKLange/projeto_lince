import 'package:flutter/material.dart';
import '../database/database_manager.dart';

class EditManagerScreen extends StatefulWidget {
  final Manager manager;

  const EditManagerScreen({super.key, required this.manager});

  @override
  EditManagerScreenState createState() => EditManagerScreenState();
}

class EditManagerScreenState extends State<EditManagerScreen> {
  final   _nameController      = TextEditingController();
  final   _phoneController     = TextEditingController();
  final   _cpfController       = TextEditingController();
  final   _cityController      = TextEditingController();
  final   _comissionController = TextEditingController();
  String? _selectedState;

  final List<String> _states = [
    'Acre', 'Alagoas', 'Amapá', 'Amazonas',
    'Bahia', 'Ceará', 'Distrito Federal',
    'Espírito Santo', 'Goiás', 'Maranhão',
    'Mato Grosso', 'Mato Grosso do Sul',
    'Minas Gerais', 'Pará', 'Paraíba', 'Paraná',
    'Pernambuco', 'Piauí', 'Rio de Janeiro',
    'Rio Grande do Norte', 'Rio Grande do Sul',
    'Rondônia', 'Roraima', 'Santa Catarina',
    'São Paulo', 'Sergipe', 'Tocantins'
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text      = widget.manager.name;
    _phoneController.text     = widget.manager.phone;
    _cpfController.text       = widget.manager.cpf;
    _cityController.text      = widget.manager.city;
    _comissionController.text = widget.manager.comission;
    _selectedState            = widget.manager.state;
  }

  void _updateClient() async {
    final name      = _nameController.text;
    final phone     = _phoneController.text;
    final cpf       = _cpfController.text;
    final city      = _cityController.text;
    final comission = _comissionController.text;

    if (name.isEmpty      ||
        phone.isEmpty     ||
        cpf.isEmpty       ||
        city.isEmpty      ||
        comission.isEmpty ||
        _selectedState == null) {
      _showError('All fields are required');
      return;
    }

    if (phone.length < 11) {
      _showError('Invalid phone number');
      return;
    }

    if (cpf.length != 11) {
      _showError('Invalid CPF');
      return;
    }

    Manager updatedManager = Manager(
      id:        widget.manager.id,
      name:      name,
      phone:     phone,
      cpf:       cpf,
      city:      city,
      comission: comission,
      state:     _selectedState!,
    );

    await DatabaseManager().updateManager(updatedManager);

    _showSuccess('Manager update Successfully');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error to update'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Successfully'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                maxLength: 13,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cpfController,
                maxLength: 11,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CPF',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'State',
                ),
                value: _selectedState,
                items: _states.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _comissionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Commission',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateClient,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}