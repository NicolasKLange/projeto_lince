import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _nameController            = TextEditingController();
  final _cpfController             = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _login() {
    final name            = _nameController.text;
    final cpf             = _cpfController.text;
    final password        = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty     ||
        cpf.isEmpty      ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showError('All fields are required');
      return;
    }

    if (cpf.length != 11) {
      _showError('Invalid CPF, only numbers');
      return;
    }

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  const DashboardScreen()),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.helloWorld ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              controller: _cpfController,
              maxLength: 11,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}