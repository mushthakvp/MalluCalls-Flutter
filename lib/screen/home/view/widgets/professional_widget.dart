import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import '../../../../util/colors.dart';
import '../../../../util/responsive.dart';
import '../../../call/view/call_view.dart';
import 'list_of_videos.dart';
import 'subscription.dart';

class ProfessionalWidget extends StatelessWidget {
  const ProfessionalWidget({
    super.key,
    this.data,
    this.coin,
  });
  final List<Professional>? data;
  final int? coin;

  @override
  Widget build(BuildContext context) {
    return data?.isEmpty == true
        ? Center(
            child: Text(
              'No Professional Videos Available',
              style: TextStyle(
                fontFamily: "Galano",
                color: Apc.greyColor,
                fontSize: Responsive.text! * 2,
              ),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height! * 2,
            ),
            shrinkWrap: true,
            itemCount: data?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              Professional? item = data?[index];
              return GestureDetector(
                onTap: () {
                  if (item!.videoCoin! <= coin!) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallView(data: item),
                      ),
                    );
                  } else {
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
                  }
                },
                child: ListOfVideos(item: item),
              );
            },
          );
  }
}
