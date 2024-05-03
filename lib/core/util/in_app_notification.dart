import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

class InAppNotification {
  InAppNotification._();

  static invalidEmailAndPassword({
    required BuildContext context,
  }) {
    showAppNotification(
      context: context,
      title: 'Hey!',
      message: 'Email or Password not valid',
      type: NotificationType.warning,
    );
  }

  static void successfulRegistration({
    required BuildContext context,
  }) {
    showAppNotification(
        context: context,
        title: 'Successful registration!',
        message:
            'Verification was sent to your email address, please check your email',
        type: NotificationType.success,
        isDismissible: false);
  }

  static void successfulSignUp({
    required BuildContext context,
  }) {
    showAppNotification(
        context: context,
        title: 'Successful registration!',
        message: 'Se ha guardado correctamente tu usuario',
        type: NotificationType.success,
        isDismissible: false);
  }

  static void serverFailure(
      {required BuildContext context, required String message}) {
    InAppNotification.showAppNotification(
      context: context,
      title: 'Oh no!',
      message: message,
      type: NotificationType.error,
    );
  }

  static void showAppNotification(
      {required BuildContext context,
      required String title,
      required String message,
      required NotificationType type,
      isDismissible = true}) {
    late Color notificationColor;
    late IconData notificationIcon;

    switch (type) {
      case NotificationType.error:
        notificationColor = Colors.red[900]!;
        notificationIcon = Icons.error_outline;
        break;
      case NotificationType.success:
        notificationColor = Colors.green[800]!;
        notificationIcon = Icons.verified_outlined;

        break;
      case NotificationType.warning:
        notificationColor = Colors.amberAccent[700]!;
        notificationIcon = Icons.warning_outlined;
        break;
      default:
        notificationColor = Colors.blue[500]!;
        Icons.shield_outlined;
    }
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      leftBarIndicatorColor: notificationColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      //boxShadows: AppShadows.mainShadow,
      backgroundColor: Colors.black87,
      isDismissible: isDismissible,
      duration: const Duration(seconds: 5),
      icon: Icon(
        notificationIcon,
        color: notificationColor,
        size: 30,
      ),
      padding: const EdgeInsets.all(20),
      titleText: Text(title, style: TextStyle(color: notificationColor)),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
    ).show(context);
  }
}

enum NotificationType {
  success,
  warning,
  error,
}
