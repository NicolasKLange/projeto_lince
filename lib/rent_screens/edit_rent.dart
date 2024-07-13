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

  Future<void> _pickDate(BuildContext context,
      TextEditingController controller, bool isStartDate) async {
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
        const SnackBar(content: Text('Successfully updated rent!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit rent'),
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
                  decoration: const InputDecoration(labelText: 'Start date'),
                  readOnly: true,
                  onTap: () => _pickDate(context, _startDateController, true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, insert start date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(labelText: 'End Date'),
                  readOnly: true,
                  onTap: () => _pickDate(context, _endDateController, false),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                        return 'Please, insert end date';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _updateRent,
                  child: const Text('Update rent'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
