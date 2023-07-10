import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mallu_calls/screen/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../admin/add/provider/add_view_provider.dart';
import '../admin/view/provider/video_view_provider.dart';
import '../screen/call/provider/call_provider.dart';
import '../screen/home/provider/home_provider.dart';

class ProviderApp extends StatelessWidget {
  // Lorem [Widget child]
  final Widget child;
  const ProviderApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => CallProvider()),
        ChangeNotifierProvider(create: (context) => AddViewProvider()),
        ChangeNotifierProvider(create: (context) => VideoViewProvider()),
      ],
      child: child,
    );
  }
}
