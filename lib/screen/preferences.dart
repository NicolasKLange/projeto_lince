import 'package:flutter/material.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(

          child: Center(
            child: Column(
              children: [
                Text("Olá mundo", style: TextStyle(fontSize: 20),),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _changeLanguagePortuguese,
                  child: Text('Portuguese'),
                ),
                ElevatedButton(
                  onPressed: _changeLanguageEnglish,
                  child: Text('English'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _changeLanguagePortuguese() async {
  const language = "Portuguese";

  print(language);
  return;
}

void _changeLanguageEnglish() async {
  final language = "English";

  print(language);
  return;
}
