import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final doc = await _firestore.collection('usuarios').doc(_user?.uid).get();
    return doc.data() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.signOut(),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data ?? {};
          
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_user?.photoURL ?? ''),
                ),
                const SizedBox(height: 20),
                Text(
                  _user?.displayName ?? 'Nombre no disponible',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(_user?.email ?? 'Email no disponible'),
                const SizedBox(height: 20),
                _buildInfoCard('Teléfono', userData['telefono'] ?? 'No registrado'),
                _buildInfoCard('Dirección', userData['direccion'] ?? 'No registrada'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) => Card(
    child: ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    ),
  );
}