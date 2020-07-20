import 'dart:math';

import 'package:aquariusstore/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  Future<String> uploadImage(bool opc, Product product) async {
    var photo;
    try {
      if (opc) {
        //true
        photo = await ImagePicker.pickImage(source: ImageSource.camera);
      } else {
        //false
        photo = await ImagePicker.pickImage(source: ImageSource.gallery);
      }
    } catch (e) {
      Get.snackbar('Permissão negada',
          'Você precisa permitir antes de utilizar esta função.');
    }

    if (photo != null) {
      return _uploadPhoto(photo, product);
    }
  }

  removeImage(String productId, int index) {
    FirebaseStorage()
        .ref()
        .child('/productsImage/$productId/' + index.toString())
        .delete();
  }

  Future<String> _uploadPhoto(var photo, Product product) async {
    try {
      var storageReference = FirebaseStorage().ref().child(
            '/productsImage/${product.id}/' +
                product.imagesUrl.length.toString(),
          );
      var uploadTask = storageReference.putFile(photo);
      await uploadTask.onComplete;
      return await storageReference.getDownloadURL();
    } catch (e) {
      Get.snackbar('Erro no upload',
          'Não foi possivel enviar a foto. Tente nvoamente mais tarde.');
    }
  }
}
