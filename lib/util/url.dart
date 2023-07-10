class Urls {
  static const String localHost = "http://10.0.2.2:5001/mallu/api";
  static const String baseUrl = "https://bcomfort.in/mallu/api";
  static const String signUp = "$baseUrl/login/addUser";
  static const String login = "$baseUrl/login/getUser/";
  static const String getVideo = "$baseUrl/video/getVideo";
  static const String watchedVideo = "$baseUrl/video/addView";
  static const String addVideo = "$baseUrl/video/addVideo";
  static const String addCoin = "$baseUrl/video/addCoin";
  static const String getVideos = "$baseUrl/video/getAllVideo";
  static const String deleteVideos = "$baseUrl/video/deleteVideo";

  static String stripeConfirm = "";
}
