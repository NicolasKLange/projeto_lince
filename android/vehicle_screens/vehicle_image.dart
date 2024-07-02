import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../database/database_imagem.dart';

class VehicleImageScreen extends StatefulWidget {
  const VehicleImageScreen({super.key});

  @override
  _VehicleImageScreenState createState() => _VehicleImageScreenState();
}

class _VehicleImageScreenState extends State<VehicleImageScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<XFile?> _vehicleImages = [];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        if (_vehicleImages.length < 6) {
          _vehicleImages.add(image);
        }
      });
    }
  }

  Future<void> _registerVehicle() async {
    if (_nameController.text.isEmpty || _vehicleImages.length < 6) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, preencha o nome e selecione 6 fotos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Converta a lista de XFile para a lista de strings dos caminhos das imagens
      List<String> imagePaths = _vehicleImages.map((xFile) => xFile!.path).toList();
      // Salve no banco de dados
      await DatabaseImagem().insertVeiculo(_nameController.text, imagePaths);
      // Navegue para a tela de verificação de fotos
      Navigator.pushNamed(context, '/verify-photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagem Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome do Veículo',
              ),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                6,
                    (index) => _vehicleImages.length > index
                    ? Image.file(
                  File(_vehicleImages[index]!.path),
                  width: 100,
                  height: 100,
                )
                    : InkWell(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _registerVehicle,
              child: Text('Cadastrar Veículo'),
            ),
          ],
        ),
      ),
    );
  }
}
