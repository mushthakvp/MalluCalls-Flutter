class VideoModel {
  List<Professional>? professional;
  List<Professional>? video;
  int? userReward;
  String? userName;
  String? userImage;

  VideoModel({
    this.professional,
    this.video,
    this.userReward,
    this.userName,
    this.userImage,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        professional: json["professional"] == null
            ? []
            : List<Professional>.from(
                json["professional"]!.map((x) => Professional.fromJson(x))),
        video: json["video"] == null
            ? []
            : List<Professional>.from(
                json["video"]!.map((x) => Professional.fromJson(x))),
        userReward: json["userReward"],
        userName: json["userName"],
        userImage: json["userImage"],
      );

  Map<String, dynamic> toJson() => {
        "professional": professional == null
            ? []
            : List<dynamic>.from(professional!.map((x) => x.toJson())),
        "video": video == null
            ? []
            : List<dynamic>.from(video!.map((x) => x.toJson())),
        "userReward": userReward,
        "userName": userName,
        "userImage": userImage,
      };
}

class Professional {
  String? id;
  String? videoUser;
  int? videoCoin;
  String? videoProfile;
  String? videoUrl;
  String? videoPlace;
  bool? videoNormal;
  DateTime? videoCreatedAt;
  int? v;

  Professional({
    this.id,
    this.videoUser,
    this.videoCoin,
    this.videoProfile,
    this.videoUrl,
    this.videoPlace,
    this.videoNormal,
    this.videoCreatedAt,
    this.v,
  });

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
        id: json["_id"],
        videoUser: json["videoUser"],
        videoCoin: json["videoCoin"],
        videoProfile: json["videoProfile"],
        videoUrl: json["videoUrl"],
        videoPlace: json["videoPlace"],
        videoNormal: json["videoNormal"],
        videoCreatedAt: json["videoCreatedAt"] == null
            ? null
            : DateTime.parse(json["videoCreatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "videoUser": videoUser,
        "videoCoin": videoCoin,
        "videoProfile": videoProfile,
        "videoUrl": videoUrl,
        "videoPlace": videoPlace,
        "videoNormal": videoNormal,
        "videoCreatedAt": videoCreatedAt?.toIso8601String(),
        "__v": v,
      };
}
