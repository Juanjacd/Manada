import 'package:flutter/material.dart';
import 'dog_walkers_screen.dart';
import 'owner_service_screen.dart';

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
          // Overlay para atenuar: 30% de opacidad (0.3 * 255 ≈ 77)
          Container(
            color: Colors.black.withAlpha(77),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Bienvenido a La Manada",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Espacio para bajar los botones
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DogWalkersScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text("Soy Paseador"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OwnerServiceScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text("Soy Papá/Mamá de Mascota"),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
