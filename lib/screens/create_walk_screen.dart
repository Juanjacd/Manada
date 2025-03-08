import 'package:flutter/material.dart';

class CreateWalkScreen extends StatefulWidget {
  const CreateWalkScreen({super.key});

  @override
  CreateWalkScreenState createState() => CreateWalkScreenState();
}

class CreateWalkScreenState extends State<CreateWalkScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedPaymentMethod = 'Efectivo';

  Future<void> _scheduleWalk() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Capturamos las referencias antes del gap asíncrono
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    
    // Simular proceso de agendamiento
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    messenger.showSnackBar(
      const SnackBar(content: Text('Paseo agendado exitosamente')),
    );
    navigator.pop();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      _timeController.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar Paseo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Fecha
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Fecha del paseo',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                readOnly: true,
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecciona una fecha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Hora
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Hora del paseo',
                  prefixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                readOnly: true,
                onTap: _pickTime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecciona una hora';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Precio
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el precio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Método de pago
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: InputDecoration(
                  labelText: 'Método de pago',
                  prefixIcon: const Icon(Icons.payment),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: <String>['Efectivo', 'Tarjeta', 'Otro']
                    .map((method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _scheduleWalk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Agendar Paseo',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

