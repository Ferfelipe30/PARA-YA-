import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

Future<bool> uploadImage(File image) async {
  // ignore: avoid_print
  print(image.path);
  final String nameFile = image.path.split("/").last;
  final Reference ref = storage.ref().child("images").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  // ignore: avoid_print
  print(uploadTask);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  // ignore: avoid_print
  print(snapshot);
  final String url = await snapshot.ref.getDownloadURL();
  // ignore: avoid_print
  print(url);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
