import 'package:flutter/material.dart';
import '../database/database_client.dart';

class EditClientScreen extends StatefulWidget {
  final Client client;

  const EditClientScreen({super.key, required this.client});

  @override
  EditClientScreenState createState() => EditClientScreenState();
}

class EditClientScreenState extends State<EditClientScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnpjController = TextEditingController();

  final List<String> _states = [
    'Acre', 'Alagoas', 'Amapá', 'Amazonas', 'Bahia', 'Ceará', 'Distrito Federal',
    'Espírito Santo', 'Goiás', 'Maranhão', 'Mato Grosso', 'Mato Grosso do Sul',
    'Minas Gerais', 'Pará', 'Paraíba', 'Paraná', 'Pernambuco', 'Piauí',
    'Rio de Janeiro', 'Rio Grande do Norte', 'Rio Grande do Sul', 'Rondônia',
    'Roraima', 'Santa Catarina', 'São Paulo', 'Sergipe', 'Tocantins'
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.client.name;
    _phoneController.text = widget.client.phone;
    _cnpjController.text = widget.client.cnpj;
  }

  void _updateClient() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final cnpj = _cnpjController.text;

    if (name.isEmpty || phone.isEmpty || cnpj.isEmpty) {
      _showError('Todos os campos são obrigatórios');
      return;
    }

    Client updatedClient = Client(
      id: widget.client.id,
      name: name,
      phone: phone,
      cnpj: cnpj,
    );

    await DatabaseClient().updateClient(updatedClient);

    _showSuccess('Cliente atualizado com sucesso');
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
              Navigator.of(context).pop(true); // Voltar para a tela anterior
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
        title: const Text('Editar Cliente'),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefone',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cnpjController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CNPJ',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateClient,
                child: const Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}