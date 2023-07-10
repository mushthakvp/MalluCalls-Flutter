// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import '../../../../util/colors.dart';
import '../../../../util/popup.dart';
import '../../../../util/responsive.dart';
import '../../../../util/server.dart';
import '../../../../util/url.dart';

class SubscriptionBottomSheet extends StatefulWidget {
  const SubscriptionBottomSheet({
    super.key,
  });

  @override
  State<SubscriptionBottomSheet> createState() =>
      _SubscriptionBottomSheetState();
}

class _SubscriptionBottomSheetState extends State<SubscriptionBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  int getAmount() {
    switch (index) {
      case 0:
        return 499 * 100;
      case 1:
        return 699 * 100;
      case 2:
        return 999 * 100;
      default:
        return 499 * 100;
    }
  }

  Map<String, dynamic>? paymentInstance;
  bool stripLoading = false;

  Future<void> stripeInitiate() async {
    try {
      setState(() {
        stripLoading = true;
      });
      Map<String, dynamic> data = {
        'amount': "${getAmount()}",
        'currency': 'INR',
        'payment_method_types[]': 'card',
        'description': 'Mallu Calls Subscription Payment',
      };

      String testKey =
          "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";
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: data,
        headers: {
          "Authorization": "Bearer $testKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        paymentInstance = json.decode(response.body);
        stripeSheet();
      }
    } catch (e) {
      log("error $e");
    } finally {
      setState(() {
        stripLoading = false;
      });
    }
  }

  void stripeSheet() async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentInstance?['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Mallu Calls',
        ),
      );
      await Stripe.instance.presentPaymentSheet().then((value) {
        updateSubscription();
        context.loaderOverlay.show();
      }).onError((error, stackTrace) {
        log("Error $error $stackTrace");
        PopUp.show(
          message: "Payment Failed",
          type: PopUpType.warning,
        );
      });
    } catch (e) {
      log("Error $e");
    }
  }

  void updateSubscription() async {
    List response = await Server.post(Urls.addCoin, data: {
      'coin': index == 0
          ? 510
          : index == 1
              ? 725
              : 1050
    });
    if (response.first >= 200 && response.first <= 299) {
      PopUp.show(
        message: "Subscription Updated",
        type: PopUpType.success,
      );
      context.loaderOverlay.hide();
      Navigator.pop(context);
    } else {
      PopUp.show(
        message: "Something went wrong",
        type: PopUpType.error,
      );
      context.loaderOverlay.hide();
    }
  }

  Color buttonColor = Apc.greenColor;
  int index = 0;

  void subscription({required int index}) {
    switch (index) {
      case 0:
        setState(() {
          this.index = index;
          buttonColor = Apc.greenColor;
        });
        break;
      case 1:
        setState(() {
          this.index = index;
          buttonColor = Apc.primaryColor;
        });
        break;
      case 2:
        setState(() {
          this.index = index;
          buttonColor = Apc.redColor;
        });
        break;
      default:
        this.index = index;
        buttonColor = Apc.greenColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width! * 5,
      ),
      width: Responsive.width! * 100,
      decoration: const BoxDecoration(
        color: Apc.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Responsive.height! * 6),
              Text(
                "Need coin for video call",
                style: TextStyle(
                  fontFamily: 'Galano',
                  fontSize: Responsive.text! * 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Responsive.height! * 1),
              Text(
                "You don't have enough coin to make a video call. Please buy more coin to make a video call.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Galano',
                  fontSize: Responsive.text! * 2,
                ),
              ),
              SizedBox(height: Responsive.height! * 3),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        subscription(index: 0);
                      },
                      child: Container(
                        height: Responsive.height! * 16,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Apc.greenColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          child: Banner(
                            message: "10 Coins Extra",
                            color: Apc.greenColor,
                            textStyle: TextStyle(
                              color: Apc.whiteColor,
                              fontFamily: 'Galano',
                              fontSize: Responsive.text! * 1,
                              fontWeight: FontWeight.bold,
                            ),
                            location: BannerLocation.topStart,
                            child: Column(
                              children: [
                                SizedBox(height: Responsive.height! * 2),
                                CircleAvatar(
                                  radius: Responsive.radius! * 5,
                                  backgroundColor: Apc.greenColor,
                                  child: Icon(
                                    Icons.bolt,
                                    color: Apc.whiteColor,
                                    size: Responsive.radius! * 6,
                                  ),
                                ),
                                SizedBox(height: Responsive.height! * 2),
                                Text(
                                  "500 Coin",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "₹ 49",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 2.5,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.greenColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "9 only/",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 1.6,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.greenColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.width! * 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        subscription(index: 1);
                      },
                      child: ClipRRect(
                        child: Banner(
                          message: "25 Coins Extra",
                          color: Apc.primaryColor,
                          textStyle: TextStyle(
                            color: Apc.whiteColor,
                            fontFamily: 'Galano',
                            fontSize: Responsive.text! * 1,
                            fontWeight: FontWeight.bold,
                          ),
                          location: BannerLocation.topStart,
                          child: Container(
                            height: Responsive.height! * 16,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Apc.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: Responsive.height! * 2),
                                CircleAvatar(
                                  radius: Responsive.radius! * 5,
                                  backgroundColor: Apc.primaryColor,
                                  child: Icon(
                                    Icons.keyboard_command_key,
                                    color: Apc.whiteColor,
                                    size: Responsive.radius! * 6,
                                  ),
                                ),
                                SizedBox(height: Responsive.height! * 2),
                                Text(
                                  "700 Coin",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "₹ 69",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 2.5,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.primaryColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "9 only/",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 1.6,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.width! * 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        subscription(index: 2);
                      },
                      child: ClipRRect(
                        child: Banner(
                          message: "50 Coins Extra",
                          color: Apc.redColor,
                          textStyle: TextStyle(
                            color: Apc.whiteColor,
                            fontFamily: 'Galano',
                            fontSize: Responsive.text! * 1,
                            fontWeight: FontWeight.bold,
                          ),
                          location: BannerLocation.topStart,
                          child: Container(
                            height: Responsive.height! * 16,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Apc.redColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: Responsive.height! * 2),
                                CircleAvatar(
                                  radius: Responsive.radius! * 5,
                                  backgroundColor: Apc.redColor,
                                  child: Icon(
                                    Icons.switch_access_shortcut,
                                    color: Apc.whiteColor,
                                    size: Responsive.radius! * 6,
                                  ),
                                ),
                                SizedBox(height: Responsive.height! * 2),
                                Text(
                                  "1000 Coin",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Galano',
                                    fontSize: Responsive.text! * 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "₹ 99",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 2.5,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.redColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "9 only/",
                                        style: TextStyle(
                                          fontFamily: 'Galano',
                                          fontSize: Responsive.text! * 1.6,
                                          fontWeight: FontWeight.bold,
                                          color: Apc.redColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height! * 3),
              SizedBox(
                width: Responsive.width! * 100,
                height: Responsive.height! * 6,
                child: ElevatedButton(
                  onPressed: () {
                    stripeInitiate();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: stripLoading
                      ? const CupertinoActivityIndicator(
                          color: Apc.whiteColor,
                        )
                      : Text(
                          "Buy Coin",
                          style: TextStyle(
                            fontFamily: 'Galano',
                            fontSize: Responsive.text! * 2,
                            fontWeight: FontWeight.bold,
                            color: Apc.whiteColor,
                          ),
                        ),
                ),
              ),
              SizedBox(height: Responsive.height! * 3),
            ],
          ),
          Positioned(
            top: -Responsive.height! * 5,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Apc.whiteColor,
                  radius: 45,
                  child: Lottie.asset('assets/animation/crying.json'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
