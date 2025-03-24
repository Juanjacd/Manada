import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:paseos_mascotas/services/auth_service.dart';
import 'role_selection_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithEmail() async {
    try {
      final result = await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (result != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al iniciar sesión con correo.")),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error en Email Sign-In: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en Email Sign-In: $e")),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      // ignore: avoid_print
      print("Iniciando Google Sign-In...");
      final result = await _authService.signInWithGoogle();
      // ignore: avoid_print
      print("Resultado de Google Sign-In: $result");
      if (result != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
        );
      } else {
        // ignore: avoid_print
        print("No se pudo iniciar sesión con Google.");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al iniciar sesión con Google.")),
        );
      }
    } catch (e, s) {
      // ignore: avoid_print
      print("Error en Google Sign-In: $e");
      // ignore: avoid_print
      print("Stacktrace: $s");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en Google Sign-In: $e")),
      );
    }
  }

  Future<void> _loginWithFacebook() async {
    try {
      final result = await _authService.signInWithFacebook();
      if (result != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al iniciar sesión con Facebook.")),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error en Facebook Sign-In: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en Facebook Sign-In: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Imagen de fondo y overlay
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/login_background.jpg",
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withAlpha(51),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Título animado "Manada"
                      AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'Manada',
                            textStyle: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                      const SizedBox(height: 40),
                      // Formulario centrado y transparente
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Correo electrónico",
                                  labelStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: "Contraseña",
                                  labelStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _loginWithEmail,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text("Iniciar sesión"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Enlace para registrarse
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          "¿No tienes cuenta? Regístrate",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botones para Google y Facebook
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _loginWithGoogle,
                            child: Image.asset(
                              "assets/images/google_icon.png",
                              height: 50,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: _loginWithFacebook,
                            child: Image.asset(
                              "assets/images/facebook_icon.png",
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
