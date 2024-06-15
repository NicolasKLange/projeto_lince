import 'package:flutter/material.dart';
import '../database/database_client.dart';

class EditClientScreen extends StatefulWidget {
  final Client client;

  EditClientScreen({required this.client});

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _cityController = TextEditingController();
  String? _selectedState;

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
    _cityController.text = widget.client.city;
    _selectedState = widget.client.state;
  }

  void _updateClient() async {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final cnpj = _cnpjController.text;
    final city = _cityController.text;

    if (name.isEmpty || phone.isEmpty || cnpj.isEmpty || city.isEmpty || _selectedState == null) {
      _showError('Todos os campos são obrigatórios');
      return;
    }

    Client updatedClient = Client(
      id: widget.client.id,
      name: name,
      phone: phone,
      cnpj: cnpj,
      city: city,
      state: _selectedState!,
    );

    await DatabaseClient().updateClient(updatedClient);

    _showSuccess('Cliente atualizado com sucesso');
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sucesso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(true); // Voltar para a tela anterior
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefone',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cnpjController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CNPJ',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cidade',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateClient,
                child: Text('Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}