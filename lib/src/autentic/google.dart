import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class google {
  static Future<User?> iniciarSeccion({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogle = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount = await objGoogle.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      try {
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        return user;
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print('Error en la autenticacion de Google');
      }
    }
    return null;
  }
}
