import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import 'package:mallu_calls/util/server.dart';
import 'package:mallu_calls/util/url.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../util/colors.dart';
import '../../../util/responsive.dart';
import '../provider/call_provider.dart';
import 'widgets/call_screen_loading.dart';

class CallView extends StatefulWidget {
  const CallView({
    super.key,
    this.data,
  });
  final Professional? data;

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  CameraController? cameraController;
  CallProvider? callProvider;
  bool videoCamera = true;
  Duration videoDuration = const Duration(seconds: 0);
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  VideoPlayerController? controller;
  bool isCameraExpanded = false;
  double? right;
  double? top;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      cameraController = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: false,
      );
      cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
    callProvider = context.read<CallProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _playAudio();
    });
  }

  Future<void> _playAudio() async {
    assetsAudioPlayer
        .open(Audio('assets/audio/ring.m4a'), autoStart: true)
        .then((value) {
      assetsAudioPlayer.play().then((value) {
        assetsAudioPlayer.setLoopMode(LoopMode.single);
        _playVideo();
      });
    });
  }

  Future<void> _playVideo() async {
    await Future.delayed(const Duration(seconds: 5));
    if (assetsAudioPlayer.isPlaying.value) {
      controller = VideoPlayerController.network(widget.data!.videoUrl!);
      await controller!.initialize();
      Server.post(Urls.watchedVideo, data: {
        "videoId": widget.data!.id,
        "coin": widget.data!.videoCoin,
      });
      controller!.addListener(() {
        callProvider?.setVideoDuration(controller!.value.position);
        if (controller!.value.position >= controller!.value.duration) {
          Navigator.pop(context);
        }
      });
      setState(() {
        assetsAudioPlayer.stop();
        controller!.play();
      });
    }
  }

  @override
  void dispose() {
    callProvider = null;
    cameraController?.dispose();
    assetsAudioPlayer.stop();
    controller?.pause();
    controller?.dispose();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller?.value.isInitialized == true
          ? Container(
              height: Responsive.height! * 100,
              width: Responsive.width! * 100,
              color: Apc.blackColor,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: !isCameraExpanded,
                    child: VideoWidget(controller: controller!),
                  ),
                  Positioned(
                    right: right ?? Responsive.width! * 4,
                    top: top ?? Responsive.height! * 7,
                    child: GestureDetector(
                      onTap: () {
                        if (isCameraExpanded == false) {
                          setState(() {
                            right = 0;
                            top = 0;
                            isCameraExpanded = !isCameraExpanded;
                          });
                        }
                      },
                      child: Container(
                        height: isCameraExpanded
                            ? Responsive.height! * 100
                            : Responsive.height! * 12,
                        width: isCameraExpanded
                            ? Responsive.width! * 100
                            : Responsive.width! * 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: videoCamera
                              ? Apc.blackColor.withOpacity(0.5)
                              : Apc.blackColor,
                        ),
                        child: videoCamera
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cameraController != null &&
                                        cameraController!.value.isInitialized
                                    ? CameraPreview(cameraController!)
                                    : Container(
                                        color: Apc.blackColor,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.videocam_off_outlined,
                                              color: Apc.whiteColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Please wait...',
                                              style: TextStyle(
                                                color: Apc.whiteColor,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Apc.blackColor,
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.videocam_off_outlined,
                                      color: Apc.whiteColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Video Off',
                                      style: TextStyle(
                                        color: Apc.whiteColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: isCameraExpanded,
                    child: Positioned(
                      right: Responsive.width! * 4,
                      top: Responsive.height! * 7,
                      child: GestureDetector(
                        onTap: () {
                          if (isCameraExpanded == true) {
                            setState(() {
                              right = Responsive.width! * 4;
                              top = Responsive.height! * 7;
                              isCameraExpanded = !isCameraExpanded;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: Responsive.height! * 12,
                          width: Responsive.width! * 22,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: VideoPlayer(controller!),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // CameraWidget(
                  //   videoCamera: videoCamera,
                  //   cameraController: cameraController,
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width! * 10,
                        ),
                        width: Responsive.width! * 100,
                        height: Responsive.height! * 11,
                        decoration: BoxDecoration(
                          color: Apc.blackColor.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Responsive.radius! * 5),
                            topRight: Radius.circular(Responsive.radius! * 5),
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  videoCamera = !videoCamera;
                                });
                              },
                              child: Icon(
                                videoCamera
                                    ? Icons.videocam
                                    : Icons.videocam_off,
                                color: Apc.whiteColor,
                                size: 30,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Apc.redColor,
                                radius: 30,
                                child: Icon(
                                  Icons.call_end,
                                  color: Apc.whiteColor,
                                  size: 30,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller?.value.volume == 0
                                      ? controller?.setVolume(1)
                                      : controller?.setVolume(0);
                                });
                              },
                              child: Icon(
                                controller?.value.volume == 0
                                    ? Icons.volume_off
                                    : Icons.volume_up,
                                color: Apc.whiteColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: Responsive.height! * 10,
                    child: Selector<CallProvider, Duration>(
                      selector: (context, provider) => provider.videoDuration,
                      builder: (context, videoDuration, _) {
                        return Text(
                          videoDuration.toString().split('.')[0],
                          style: TextStyle(
                            color: Apc.whiteColor,
                            fontSize: Responsive.width! * 4,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : CallingScreenLoading(
              audioPlayer: assetsAudioPlayer,
              data: widget.data,
            ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );
  }
}

class CameraWidget extends StatelessWidget {
  const CameraWidget({
    super.key,
    required this.videoCamera,
    required this.cameraController,
    this.right,
    this.top,
  });

  final double? right;
  final double? top;
  final bool videoCamera;
  final CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right ?? Responsive.width! * 4,
      top: top ?? Responsive.height! * 7,
      child: Container(
        height: Responsive.height! * 12,
        width: Responsive.width! * 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: videoCamera ? Apc.blackColor.withOpacity(0.5) : Apc.blackColor,
        ),
        child: videoCamera
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cameraController != null &&
                        cameraController!.value.isInitialized
                    ? CameraPreview(cameraController!)
                    : Container(
                        color: Apc.blackColor,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam_off_outlined,
                              color: Apc.whiteColor,
                              size: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Please wait...',
                              style: TextStyle(
                                color: Apc.whiteColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Apc.blackColor,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam_off_outlined,
                      color: Apc.whiteColor,
                      size: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Video Off',
                      style: TextStyle(
                        color: Apc.whiteColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
