import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(6.244203, -75.581211),
    zoom: 14,
  );

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Función separada para el logout y la navegación
  Future<void> _signOutAndNavigate() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paseos de Mascotas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOutAndNavigate,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                // Si en el futuro necesitas el controlador, puedes asignarlo aquí.
                // Ejemplo: _mapController = controller;
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Servicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configuración",
          ),
        ],
      ),
    );
  }
}
