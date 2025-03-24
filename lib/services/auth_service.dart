import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmail(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Actualiza el displayName
      await credential.user?.updateDisplayName(name);
      return credential;
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final AccessToken? fbAccessToken = result.accessToken;
      if (result.status == LoginStatus.success && fbAccessToken != null) {
        // Extraer el token a partir del JSON
        final String fbToken = fbAccessToken.toJson()['token'];
        final OAuthCredential credential = FacebookAuthProvider.credential(fbToken);
        return await _auth.signInWithCredential(credential);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }
}
