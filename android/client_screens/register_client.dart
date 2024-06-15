import 'package:flutter/material.dart';
import '../database/database_client.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  RegisterClientScreenState createState() => RegisterClientScreenState();
}

class RegisterClientScreenState extends State<RegisterClientScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _cityController = TextEditingController();
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

  void _registerClient() async {
    final name  = _nameController.text;
    final phone = _phoneController.text;
    final cnpj  = _cnpjController.text;
    final city  = _cityController.text;

    if (name.isEmpty  ||
        phone.isEmpty ||
        cnpj.isEmpty  ||
        city.isEmpty  ||
        _selectedState == null)
    {
      _showError('Todos os campos são obrigatórios');
      return;
    }

    if (phone.length < 12) {
      _showError('Número de telefone inválido');
      return;
    }

    Client newClient = Client(
      name: name,
      phone: phone,
      cnpj: cnpj,
      city: city,
      state: _selectedState!,
    );

    await DatabaseClient().insertClient(newClient);

    _showSuccess('Cliente cadastrado com sucesso');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
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
        title: const Text('Sucesso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
        title: const Text('Cadastrar Cliente'),
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
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                maxLength: 13,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefone',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cnpjController,
                maxLength: 14,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CNPJ',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cidade',
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Estado',
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerClient,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}