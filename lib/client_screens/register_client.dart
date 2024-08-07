import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../database/database_client.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  RegisterClientScreenState createState() => RegisterClientScreenState();
}

class RegisterClientScreenState extends State<RegisterClientScreen> {
  final _nameController  = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnpjController  = TextEditingController();

  Future<bool> checkCNPJ(String cnpj) async {
    final response = await http.get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void _registerClient() async {
    final name  = _nameController.text;
    final phone = _phoneController.text;
    final cnpj  = _cnpjController.text;

    if (name.isEmpty  ||
        phone.isEmpty ||
        cnpj.isEmpty) {
      _showError('All fields are required');
      return;
    }

    if (phone.length < 11) {
      _showError('Invalid phone number');
      return;
    }

    var isValidCNPJ = await checkCNPJ(cnpj);
    if (!isValidCNPJ) {
      _showError('CNPJ invalid or not found');
      return;
    }

    var newClient = Client(
      name: name,
      phone: phone,
      cnpj: cnpj,
    );

    await DatabaseClient().insertClient(newClient);
    _showSuccess('Client successfully registered');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
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
        title: const Text('Register Client'),
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
                controller: _cnpjController,
                maxLength: 14,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CNPJ',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerClient,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
