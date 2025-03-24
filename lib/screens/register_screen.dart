import 'package:flutter/material.dart';
import 'package:paseos_mascotas/services/auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      final result = await _authService.signUpWithEmail(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (result != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al registrarse.")));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack para la imagen de fondo.
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/login_background.jpg", // Puedes usar otra imagen si lo prefieres.
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withAlpha(51),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Regístrate en Manada",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50), // Muy transparente
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Nombre",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Correo electrónico",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text("Registrarse"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "¿Ya tienes cuenta? Inicia sesión",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
