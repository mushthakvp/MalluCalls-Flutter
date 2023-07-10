import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import '../../../../util/colors.dart';
import '../../../../util/responsive.dart';

class CallingScreenLoading extends StatelessWidget {
  const CallingScreenLoading({
    super.key,
    required this.audioPlayer,
    this.data,
  });
  final Professional? data;

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height! * 100,
      width: Responsive.width! * 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff671af0),
            Color(0xFF712CE9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: Responsive.height! * 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                color: Apc.whiteColor,
                size: 13,
              ),
              const SizedBox(width: 5),
              Text(
                'End to End Encrypted',
                style: TextStyle(
                  color: Apc.whiteColor,
                  fontSize: Responsive.text! * 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height! * 5),
          CircleAvatar(
            backgroundColor: Apc.whiteColor,
            radius: Responsive.radius! * 14,
            backgroundImage: CachedNetworkImageProvider(data?.videoProfile ??
                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
          ),
          SizedBox(height: Responsive.height! * 4),
          Text(
            data?.videoUser ?? "Unknown",
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: Apc.whiteColor,
              fontSize: Responsive.text! * 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.height! * 2),
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "Calling...",
                speed: const Duration(milliseconds: 200),
                textStyle: TextStyle(
                  color: Apc.whiteColor,
                  fontSize: Responsive.text! * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.width! * 10,
            ),
            width: Responsive.width! * 100,
            height: Responsive.height! * 11,
            decoration: BoxDecoration(
              color: Apc.whiteColor.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.radius! * 5),
                topRight: Radius.circular(Responsive.radius! * 5),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.mic_off,
                  color: Apc.whiteColor,
                  size: 30,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    audioPlayer.stop();
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
                const Icon(
                  Icons.volume_up,
                  color: Apc.whiteColor,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
