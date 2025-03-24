import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';

class OwnerServiceScreen extends StatefulWidget {
  const OwnerServiceScreen({super.key});
  
  @override
  // ignore: library_private_types_in_public_api
  _OwnerServiceScreenState createState() => _OwnerServiceScreenState();
}

class _OwnerServiceScreenState extends State<OwnerServiceScreen> {
  GoogleMapController? _mapController;
  late VideoPlayerController _videoController;
  bool _isVideoFinished = false;

  static const CameraPosition _defaultPosition = CameraPosition(
    target: LatLng(6.244203, -75.581211),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _videoController = VideoPlayerController.asset(
      'assets/images/paseador_con_tres_perros_en_un_parque.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.setLooping(false);
        _videoController.addListener(() {
          if (_videoController.value.isInitialized &&
              _videoController.value.position.inSeconds >=
                  _videoController.value.duration.inSeconds) {
            setState(() {
              _isVideoFinished = true;
            });
            _determinePositionAndAnimate();
          }
        });
      });
  }

  Future<void> _determinePositionAndAnimate() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
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
      body: _isVideoFinished
          ? Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: _defaultPosition,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: _onMapCreated,
                  ),
                ),
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
            )
          : Center(
              child: _videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    )
                  : const CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
