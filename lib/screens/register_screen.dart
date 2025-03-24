import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pantalla de Registro",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              // Aquí puedes agregar formularios y campos de registro
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Volver"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
