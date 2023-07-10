import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mallu_calls/util/popup.dart';
import 'package:mallu_calls/util/providers.dart';
import 'package:mallu_calls/util/responsive.dart';
import 'package:mallu_calls/util/routes.dart';
import 'screen/splash/view/splash_view.dart';

Future<void> main() async {
  String testKey =
      "pk_live_51NRd2uSAjzPLp1XKXHz3TejwOqreuuRq2vQTWujVN66D0lanbfMc88bj3lwtiCsZ12wN2xgz7XJRhOT3hm1x29Td00IIormnLB";
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = testKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderApp(
      child: ResponsiveWidget(
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: const Center(
            child: CircularProgressIndicator(
              color: Color(0xff671af0),
            ),
          ),
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: "Galano",
              useMaterial3: true,
            ),
            navigatorKey: Routes.key,
            scaffoldMessengerKey: PopUp.key,
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
          ),
        ),
      ),
    );
  }
}
