import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DogWalkersScreen extends StatelessWidget {
  const DogWalkersScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paseadores Cerca")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('paseadores').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(data["nombre"] ?? "Sin nombre"),
                  subtitle: Text("Distancia: ${data["distancia"] ?? "N/A"}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Asignado a ${data["nombre"]}")),
                      );
                    },
                    child: const Text("Asignar"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
