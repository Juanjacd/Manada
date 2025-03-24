import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CreateWalkScreen extends StatefulWidget {
  const CreateWalkScreen({super.key});
  
  @override
  State<CreateWalkScreen> createState() => _CreateWalkScreenState();
}

class _CreateWalkScreenState extends State<CreateWalkScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _mascotaController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  
  void _crearPaseo() async {
    try {
      final fechaFormato = DateFormat('yyyy-MM-dd').parseStrict(_fechaController.text);
      final horaFormato = DateFormat('hh:mm a').parseStrict(_horaController.text);
      
      await _firestore.collection('paseos').add({
        "mascota": _mascotaController.text,
        "fecha": Timestamp.fromDate(fechaFormato),
        "hora": Timestamp.fromDate(horaFormato),
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paseo creado exitosamente")),
      );
      Navigator.pop(context);
    } catch (e) {
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
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: "Fecha (YYYY-MM-DD)"),
            ),
            TextField(
              controller: _horaController,
              decoration: const InputDecoration(labelText: "Hora (hh:mm AM/PM)"),
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
