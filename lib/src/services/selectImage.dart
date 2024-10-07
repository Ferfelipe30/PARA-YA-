import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage() async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<XFile?> getFoto() async {
  final picker = ImagePicker();
  final XFile? foto = await picker.pickImage(source: ImageSource.camera);
  return foto;
}
