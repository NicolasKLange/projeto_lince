import 'package:flutter/material.dart';

class ImagensScreen extends StatelessWidget {
  const ImagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagens'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Imagem Veículo'),
            onTap: () {
              Navigator.pushNamed(context, '/vehicle-image');
            },
          ),
          ListTile(
            title: Text('Verificar Fotos'),
            onTap: () {
              Navigator.pushNamed(context, '/verify-photos');
            },
          ),
        ],
      ),
    );
  }
}
