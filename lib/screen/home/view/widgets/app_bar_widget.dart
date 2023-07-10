import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import '../../../../util/colors.dart';
import '../../../../util/responsive.dart';
import 'reward_card.dart';
import 'subscription.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.data,
  });

  final VideoModel data;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff671af0),
              Color(0xff671af0),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Responsive.height! * 12),
            CustomPaint(
              size: Size(
                Responsive.width! * 90,
                Responsive.height! * 13,
              ),
              painter: AtmCard(),
              child: SizedBox(
                height: Responsive.height! * 13,
                width: Responsive.width! * 90,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: Responsive.width! * 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: data.userImage != null
                                      ? CachedNetworkImageProvider(
                                          data.userImage ?? '',
                                        )
                                      : null,
                                  radius: Responsive.radius! * 7,
                                ),
                                SizedBox(height: Responsive.height! * 1),
                                Text(
                                  data.userName ?? 'Mallu Calls',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Apc.whiteColor,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width! * 10,
                            height: Responsive.height! * 6,
                            child: const VerticalDivider(
                              color: Apc.whiteColor,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Balance',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Apc.whiteColor,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2,
                                  ),
                                ),
                                SizedBox(height: Responsive.height! * 0.5),
                                Text(
                                  '₹ ${data.userReward ?? ''}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Apc.whiteColor,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2.2,
                                  ),
                                ),
                                SizedBox(height: Responsive.height! * 1),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return const SubscriptionBottomSheet();
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Responsive.width! * 2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.width! * 4,
                                      vertical: Responsive.height! * 0.8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Apc.whiteColor,
                                      borderRadius: BorderRadius.circular(
                                        Responsive.radius! * 10,
                                      ),
                                    ),
                                    child: Text(
                                      'Add Coins',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Apc.primaryColor,
                                        fontFamily: 'Galano',
                                        fontSize: Responsive.text! * 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
