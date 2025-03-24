import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class OwnerServiceScreen extends StatefulWidget {
  const OwnerServiceScreen({super.key});

  @override
  State<OwnerServiceScreen> createState() => _OwnerServiceScreenState();
}

class _OwnerServiceScreenState extends State<OwnerServiceScreen> {
  GoogleMapController? _mapController;
  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(6.244203, -75.581211), // Posición por defecto (Medellín)
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _determinePositionAndAnimate();
  }

  // Solicita permisos y obtiene la posición actual
  Future<void> _determinePositionAndAnimate() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Comprueba que los servicios de ubicación estén habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Puedes mostrar un mensaje o redirigir al usuario
      return Future.error('Location services are disabled.');
    }

    // Comprueba y solicita permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Obtén la posición actual
    Position position = await Geolocator.getCurrentPosition();
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _determinePositionAndAnimate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solicitar Servicio"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _defaultPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
            ),
          ),
          // Opciones para solicitar servicio (puedes personalizarlas)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Servicio Inmediato solicitado")),
                    );
                  },
                  child: const Text("Servicio Inmediato"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Servicio Programado solicitado")),
                    );
                  },
                  child: const Text("Servicio Programado"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
