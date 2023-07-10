import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../util/colors.dart';
import '../../../../util/responsive.dart';
import '../../model/video_model.dart';

class ListOfVideos extends StatelessWidget {
  const ListOfVideos({
    super.key,
    required this.item,
  });

  final Professional? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Responsive.height! * .5,
      ),
      height: Responsive.height! * 11,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width! * 4,
        vertical: Responsive.height! * 1,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Apc.greyColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Apc.whiteColor,
                radius: Responsive.radius! * 8.5,
                backgroundImage: CachedNetworkImageProvider(
                  item?.videoProfile ??
                      'https://img.freepik.com/free-photo/beautiful-curly-girl-pointing-finger_176420-168.jpg',
                ),
              ),
              Positioned(
                bottom: 2,
                right: 3,
                child: Container(
                  height: Responsive.height! * 1.5,
                  width: Responsive.width! * 3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: Responsive.width! * 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.videoUser ?? 'John Doe',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: Responsive.text! * 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Responsive.height! * 0.5),
                Text(
                  "💰 ${item?.videoCoin} Coins For this call",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.height! * 0.5),
                Text(
                  item?.videoPlace ?? 'Bangalore',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: Responsive.text! * 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.width! * 4),
          Container(
            height: Responsive.height! * 12,
            width: Responsive.width! * 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: const Icon(
              Icons.videocam_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
