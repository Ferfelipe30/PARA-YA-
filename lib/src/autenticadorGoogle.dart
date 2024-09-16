import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> autenticadorGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await auth.signInWithCredential(credential);
    UserCredential userCredential = await auth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      await firestore.collection('users').doc().set({
        'id': user.uid,
        'name': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
      });
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
