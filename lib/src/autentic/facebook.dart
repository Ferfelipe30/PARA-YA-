import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<User?> facebook() async {
  final LoginResult result = await FacebookAuth.instance.login();
  if (result.status == LoginStatus.success) {
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    return userCredential.user;
  } else {
    // ignore: avoid_print
    print("Error al iniciar sesion con Facebook");
    return null;
  }
}
