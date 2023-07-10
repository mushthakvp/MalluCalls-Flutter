import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallu_calls/util/popup.dart';
import 'package:mallu_calls/util/server.dart';
import 'package:mallu_calls/util/url.dart';

class AddViewProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController coinsController = TextEditingController();

  File? imageFile;

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      placeController.text.isNotEmpty &&
      imageFile != null &&
      videoFile != null &&
      coinsController.text.isNotEmpty;

  bool normalCallSelected = true;

  Future<void> normalCall({required bool value}) async {
    normalCallSelected = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    } else {
      PopUp.show(message: 'Please pick from gallery', type: PopUpType.error);
    }
  }

  File? videoFile;

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      videoFile = File(pickedVideo.path);
      log(videoFile!.path);
      notifyListeners();
    } else {
      PopUp.show(message: 'Please pick from gallery', type: PopUpType.error);
    }
  }

  // upload video and image to api

  bool isLoading = false;

  final cloudinary = Cloudinary.signedConfig(
    apiKey: '814857992498647',
    apiSecret: 'kkczyI99PZLvPujlCNi5Fmt9X3k',
    cloudName: 'dtwbvfrun',
  );

  Future<void> upload() async {
    if (!isFormValid) {
      PopUp.show(
        message: 'Please fill all the fields',
        type: PopUpType.error,
      );
      return;
    }
    try {
      isLoading = true;
      notifyListeners();
      CloudinaryResponse response = await cloudinary.upload(
        file: videoFile!.path,
        fileBytes: videoFile!.readAsBytesSync(),
        resourceType: CloudinaryResourceType.video,
        folder: "MalluCalls",
      );
      CloudinaryResponse imageResponse = await cloudinary.upload(
        file: imageFile!.path,
        fileBytes: imageFile!.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: "MalluCalls",
      );

      if (response.isSuccessful && imageResponse.isSuccessful) {
        List res = await Server.post(Urls.addVideo, data: {
          "videoUser": nameController.text,
          "videoPlace": placeController.text,
          "videoCoin": coinsController.text,
          "videoUrl": response.secureUrl,
          "image": imageResponse.secureUrl,
          "videoNormal": normalCallSelected,
        });
        if (res.first >= 200 && res.first < 300) {
          PopUp.show(
            message: 'Video added successfully',
            type: PopUpType.success,
          );
          nameController.clear();
          placeController.clear();
          coinsController.clear();
          imageFile = null;
          videoFile = null;
          normalCallSelected = true;
          isLoading = false;
          notifyListeners();
        } else {
          log("Error: ${res.first} ${res.last}");
          PopUp.show(
            message: 'Something went wrong',
            type: PopUpType.error,
          );
          isLoading = false;
          notifyListeners();
        }
      } else {
        log("Error: ${response.error}");
        isLoading = false;
        notifyListeners();
        PopUp.show(
          message: 'Something went wrong',
          type: PopUpType.error,
        );
      }
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
      PopUp.show(
        message: 'Something went wrong',
        type: PopUpType.error,
      );
    }
  }

  Future<void> uploadCloudinary() async {}
}
