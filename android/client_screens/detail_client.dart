import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../database/database_client.dart';

class DetailClientScreen extends StatefulWidget {
  final Client client;

  const DetailClientScreen({super.key, required this.client});

  @override
  _DetailClientScreenState createState() => _DetailClientScreenState();
}

class _DetailClientScreenState extends State<DetailClientScreen> {
  Map<String, dynamic>? clientDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClientDetails();
  }

  Future<void> fetchClientDetails() async {
    final response = await http.get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/${widget.client.cnpj}'));

    if (response.statusCode == 200) {
      setState(() {
        clientDetails = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      _showError('Não foi possível carregar os detalhes do cliente');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : clientDetails == null
            ? const Center(child: Text('Detalhes do cliente não disponíveis'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${widget.client.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Telefone: ${widget.client.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('CNPJ: ${widget.client.cnpj}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Divider(),
            Text('Situação: ${clientDetails!['descricao_situacao_cadastral']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Razão Social: ${clientDetails!['razao_social']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Nome Fantasia: ${clientDetails!['nome_fantasia']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Logradouro: ${clientDetails!['logradouro']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Estado: ${clientDetails!['uf']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Município: ${clientDetails!['municipio']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Bairro: ${clientDetails!['bairro']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Número: ${clientDetails!['numero']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),


          ],
        ),
      ),
    );
  }
}
