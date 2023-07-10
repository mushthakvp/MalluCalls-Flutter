import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import 'package:mallu_calls/util/popup.dart';
import 'package:mallu_calls/util/server.dart';
import 'package:mallu_calls/util/url.dart';

class VideoViewProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Professional> professional = [];
  List<Professional> video = [];

  Future<void> getVideo() async {
    isLoading = true;
    try {
      List response = await Server.get(Urls.getVideos);
      if (response.first >= 200 && response.first < 300) {
        professional.clear();
        video.clear();
        VideoModel model = VideoModel.fromJson(response.last);
        professional.addAll(model.professional!);
        video.addAll(model.video!);
      } else {
        professional = [];
        video = [];
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteVideo({required String id}) async {
    try {
      isLoading = true;
      notifyListeners();
      List response = await Server.post(
        Urls.deleteVideos,
        data: {
          "videoId": id,
        },
      );
      if (response.first >= 200 && response.first < 300) {
        getVideo();
      } else {
        PopUp.show(
          message: "Error Occurred",
          type: PopUpType.warning,
        );
        isLoading = true;
        notifyListeners();
      }
    } finally {
      isLoading = true;
      notifyListeners();
    }
  }
}
