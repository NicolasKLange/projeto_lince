import 'package:flutter/material.dart';
import '../database/database_rent.dart';
import 'register_rent.dart';
import 'package:intl/intl.dart';

class EditRentScreen extends StatefulWidget {
  final Rent rent;

  const EditRentScreen({Key? key, required this.rent}) : super(key: key);

  @override
  _EditRentScreenState createState() => _EditRentScreenState();
}

class _EditRentScreenState extends State<EditRentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController(text: widget.rent.startDate);
    _endDateController = TextEditingController(text: widget.rent.endDate);
  }

  Future<void> _pickDate(BuildContext context, TextEditingController controller, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _updateRent() async {
    if (_formKey.currentState!.validate()) {
      final updatedRent = widget.rent.copyWith(
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      );
      await DatabaseRent.instance.update(updatedRent);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluguel atualizado com sucesso!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Aluguel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(labelText: 'Data de Início'),
                  readOnly: true,
                  onTap: () => _pickDate(context, _startDateController, true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de início';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(labelText: 'Data de Término'),
                  readOnly: true,
                  onTap: () => _pickDate(context, _endDateController, false),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de término';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _updateRent,
                  child: const Text('Atualizar Aluguel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
