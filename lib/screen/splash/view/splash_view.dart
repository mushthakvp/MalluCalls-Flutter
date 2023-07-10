import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mallu_calls/screen/home/view/home_view.dart';
import 'package:mallu_calls/screen/login/view/login_view.dart';
import 'package:mallu_calls/util/fade_animation.dart';
import 'package:mallu_calls/util/responsive.dart';
import 'package:mallu_calls/util/routes.dart';
import '../../../util/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      String? key = await storage.read(key: 'login');
      if (key == 'true') {
        Routes.pushRemoveUntil(screen: const HomeView());
      } else {
        Routes.pushRemoveUntil(screen: const LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apc.whiteColor,
      body: Column(
        children: [
          const Spacer(),
          const Center(
            child: FadeAnimation(
              delay: 0.9,
              child: Image(
                image: AssetImage('assets/image/logo.png'),
                height: 200,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Connect to the world',
            style: TextStyle(
              color: Apc.greyColor,
            ),
          ),
          SizedBox(height: Responsive.height! * 1.6),
        ],
      ),
    );
  }
}
