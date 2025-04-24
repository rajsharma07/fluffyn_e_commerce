import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalImageProvider extends ChangeNotifier {
  File? _image;

  LocalImageProvider(String name) {
    setImage(name);
  }

  File? getImage() => _image;
  Future<bool> isFilePresent(String name) async {
    final rootPath = await getApplicationDocumentsDirectory();
    final file = File(join(rootPath.path, "$name.jpeg"));
    return await file.exists();
  }

  Future<void> setImage(String name) async {
    if (await isFilePresent(name)) {
      final rootPath = await getApplicationDocumentsDirectory();
      _image = File(join(rootPath.path, "$name.jpeg"));
    } else {
      _image = null;
    }
    notifyListeners();
  }

  Future<void> updateImage(String name) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      final rootPath = await getApplicationDocumentsDirectory();
      if (extension(pickedFile.path).toLowerCase() == '.png') {
        final bytes = await pickedFile.readAsBytes();
        final image = img.decodeImage(bytes);
        if (image != null) {
          final jpgData = img.encodeJpg(image, quality: 85);
          final opfile = File(join(rootPath.path, "$name.jpeg"));
          await opfile.writeAsBytes(jpgData);
        } else {
          return;
        }
      } else {
        await File(pickedFile.path).copy(
          join(rootPath.path, "$name.jpeg"),
        );
      }
      _image = File(join(rootPath.path, "$name.jpeg"));
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }
}
