import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  static Future<String> uploadImage(String userId, File file) async {
    try {
      String imageRef = userId + '/' + file.path.split('/').last;

      String imageUrl = await (await FirebaseStorage.instance.ref(imageRef).putFile(file)).ref.getDownloadURL();
      
      return imageUrl;
    } catch (e) {
      print("Error while uploading the image. Check your internet connection");
      return null;
    }
  }
}