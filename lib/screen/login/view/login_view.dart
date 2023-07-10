import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/login/provider/login_provider.dart';
import 'package:mallu_calls/util/colors.dart';
import 'package:mallu_calls/util/fade_animation.dart';
import 'package:mallu_calls/util/responsive.dart';
import 'package:provider/provider.dart';

import 'widgets/paint.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = context.read<LoginProvider>();
    return Scaffold(
      backgroundColor: Apc.whiteColor.withOpacity(.98),
      body: Stack(
        children: [
          SizedBox(
            height: Responsive.height! * 60,
            width: Responsive.width! * 100,
            child: CustomPaint(
              painter: LoginPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage(
                        'assets/image/callLogin.png',
                      ),
                      height: Responsive.radius! * 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeAnimation(
              delay: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connect to the world",
                    style: TextStyle(
                      fontFamily: 'Galano',
                      fontSize: Responsive.text! * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.height! * 1.5),
                  Text(
                    "Stay connected with your loved ones no matter where you are, with ConnectNow! Our mobile app allows you to make high-quality video calls with just a few taps, ensuring that distance doesn't come in the way of your relationships.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Galano',
                      fontSize: Responsive.text! * 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: Responsive.height! * 6),
                  Selector<LoginProvider, bool>(
                      selector: (p0, p1) => p1.googleProgress,
                      builder: (context, value, _) {
                        return Container(
                          height: Responsive.height! * 6.5,
                          width: Responsive.width! * 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Responsive.radius! * 4),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7949e1),
                                Color(0xffb984fb),
                              ],
                            ),
                          ),
                          child: value
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    color: Apc.whiteColor,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    provider.signInWithGoogle();
                                  },
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                      fontFamily: 'Galano',
                                      fontSize: Responsive.text! * 2,
                                      fontWeight: FontWeight.bold,
                                      color: Apc.whiteColor,
                                    ),
                                  ),
                                ),
                        );
                      }),
                  SizedBox(height: Responsive.height! * 8)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
