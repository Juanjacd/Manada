import 'package:flutter/material.dart';

class DogWalkersScreen extends StatelessWidget {
  const DogWalkersScreen({super.key});
  
  final List<Map<String, dynamic>> _paseadores = const [
    {"nombre": "Carlos", "distancia": "0.5 km"},
    {"nombre": "María", "distancia": "1.2 km"},
    {"nombre": "Andrés", "distancia": "0.8 km"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paseadores Cerca")),
      body: ListView.builder(
        itemCount: _paseadores.length,
        itemBuilder: (context, index) {
          final paseador = _paseadores[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.deepPurple),
              title: Text(paseador["nombre"]),
              subtitle: Text("Distancia: ${paseador["distancia"]}"),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Asignado a ${paseador["nombre"]}")),
                  );
                },
                child: const Text("Asignar"),
              ),
            ),
          );
        },
      ),
    );
  }
}
