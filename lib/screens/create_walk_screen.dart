import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateWalkScreen extends StatefulWidget {
  const CreateWalkScreen({super.key});
  
  @override
  State<CreateWalkScreen> createState() => _CreateWalkScreenState();
}

class _CreateWalkScreenState extends State<CreateWalkScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _mascotaController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  
  Future<void> _crearPaseo() async {
    if (_mascotaController.text.isEmpty || _selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }
    final DateTime paseoDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    try {
      await _firestore.collection('paseos').add({
        "mascota": _mascotaController.text,
        "fecha": Timestamp.fromDate(paseoDateTime),
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paseo creado exitosamente")),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Paseo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _mascotaController,
              decoration: const InputDecoration(labelText: "Nombre de la mascota"),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickDate,
                    child: Text(_selectedDate == null
                        ? "Selecciona Fecha"
                        : "Fecha: ${_selectedDate!.toLocal().toString().split(' ')[0]}"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickTime,
                    child: Text(_selectedTime == null
                        ? "Selecciona Hora"
                        : "Hora: ${_selectedTime!.format(context)}"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _crearPaseo,
              child: const Text("Crear Paseo"),
            ),
          ],
        ),
      ),
    );
  }
}
