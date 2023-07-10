import 'package:flutter/material.dart';

class Routes {
  static final key = GlobalKey<NavigatorState>();

  static push({required var screen}) {
    key.currentState?.push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static back() {
    key.currentState?.pop();
  }

  static pushReplace({required var screen}) {
    key.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static pushRemoveUntil({required var screen}) {
    key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }
}
