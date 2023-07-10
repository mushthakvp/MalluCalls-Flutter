import 'package:flutter/material.dart';

class PopUp {
  static final key = GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    required PopUpType type,
    PopUpPosition position = PopUpPosition.top,
  }) {
    final color = _getColor(type);
    final icon = _getIcon(type);

    key.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior:
            position == PopUpPosition.top ? SnackBarBehavior.floating : null,
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        margin: position == PopUpPosition.top
            ? EdgeInsets.only(
                bottom:
                    MediaQuery.of(key.currentState!.context).size.height - 140,
                right: 20,
                left: 20,
              )
            : null,
      ),
    );
  }

  static _getColor(PopUpType type) {
    switch (type) {
      case PopUpType.success:
        return Colors.green;
      case PopUpType.error:
        return Colors.red;
      case PopUpType.warning:
        return Colors.orange;
      case PopUpType.info:
        return Colors.blue;
    }
  }

  static _getIcon(PopUpType type) {
    switch (type) {
      case PopUpType.success:
        return Icons.check;
      case PopUpType.error:
        return Icons.error_outline;
      case PopUpType.warning:
        return Icons.warning_amber_outlined;
      case PopUpType.info:
        return Icons.info_outline;
    }
  }
}

enum PopUpType {
  success,
  error,
  warning,
  info,
}

enum PopUpPosition {
  top,
  bottom,
}
