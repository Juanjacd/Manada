import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Error al iniciar sesión con Google: $e");
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success && result.accessToken != null) {
        // Convertimos el AccessToken a JSON para extraer el token.
        final Map<String, dynamic> tokenData = result.accessToken!.toJson();
        final String? token = tokenData['token'];
        if (token == null) {
          throw Exception("Error al obtener el token de Facebook");
        }
        final credential = FacebookAuthProvider.credential(token);
        return await _auth.signInWithCredential(credential);
      }
      throw Exception("Error al iniciar sesión con Facebook");
    } catch (e) {
      throw Exception("Error al iniciar sesión con Facebook: $e");
    }
  }
}
