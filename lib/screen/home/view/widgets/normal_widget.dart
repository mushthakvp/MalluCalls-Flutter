// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/home/model/video_model.dart';
import 'package:mallu_calls/util/colors.dart';
import '../../../../util/responsive.dart';
import '../../../call/view/call_view.dart';
import 'list_of_videos.dart';
import 'subscription.dart';

class NormalWidget extends StatelessWidget {
  const NormalWidget({
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
              'No Personal Videos Available',
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

class SuccessBottomSheet extends StatefulWidget {
  const SuccessBottomSheet({super.key});

  @override
  State<SuccessBottomSheet> createState() => _SuccessBottomSheetState();
}

class _SuccessBottomSheetState extends State<SuccessBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height! * 100,
      width: Responsive.width! * 100,
      decoration: const BoxDecoration(
        color: Apc.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width! * 5,
        vertical: Responsive.height! * 5,
      ),
      child: Column(
        children: [
          SizedBox(height: Responsive.height! * 2),
          Text(
            "Congratulations!",
            style: TextStyle(
              fontFamily: 'Galano',
              fontSize: Responsive.text! * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.height! * 2),
          Text(
            "You have successfully purchased the coins.",
            style: TextStyle(
              fontFamily: 'Galano',
              fontSize: Responsive.text! * 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.height! * 2),
          SizedBox(
            width: Responsive.width! * 100,
            height: Responsive.height! * 6,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Ok",
                style: TextStyle(
                  fontFamily: 'Galano',
                  fontSize: Responsive.text! * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.height! * 3),
        ],
      ),
    );
  }
}
