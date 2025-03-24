import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  MapPickerScreenState createState() => MapPickerScreenState();
}

class MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  Position? _currentPosition;
  // final String _apiKey = "AIzaSyC17iiRfRu_X6VanwAtIq_je9Lh_Slt8Pk"; // <-- Tu API Key

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() => _currentPosition = position);
      _mapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude)));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error obteniendo ubicación')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona Ubicación'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_selectedLocation != null) {
                Navigator.pop(context, _selectedLocation);
              }
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition != null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : const LatLng(6.244203, -75.581211),
          zoom: 14,
        ),
        onTap: (position) => setState(() => _selectedLocation = position),
        markers: _selectedLocation != null
            ? {Marker(markerId: const MarkerId('selected'), position: _selectedLocation!)}
            : {},
        myLocationEnabled: true,
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}