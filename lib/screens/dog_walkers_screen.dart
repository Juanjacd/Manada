import 'package:flutter/material.dart';

class DogWalkersScreen extends StatelessWidget {
  const DogWalkersScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paseadores'),
      ),
      body: Center(
        child: const Text('Pantalla de Paseadores'),
      ),
    );
  }
}
