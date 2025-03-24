// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dog_walkers_screen.dart';
import 'owner_service_screen.dart';
import '../common/loading_overlay.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo
          Image.asset(
            "assets/images/dos_perros_corriendo_en_zona_verde_de.jpeg",
            fit: BoxFit.cover,
          ),
          // Overlay semitransparente
          Container(
            color: Colors.black.withAlpha(77),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenido a La Manada",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const LoadingOverlay(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const DogWalkersScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
                    child: const Text("Soy Paseador"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const LoadingOverlay(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const OwnerServiceScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
                    child: const Text("Soy Papá/Mamá de Mascota"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
