import 'package:flutter/material.dart';

class CallProvider extends ChangeNotifier {
  Duration videoDuration = const Duration(seconds: 0);

  void setVideoDuration(Duration duration) {
    videoDuration = duration;
    notifyListeners();
  }
}
