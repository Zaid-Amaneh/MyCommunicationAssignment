import 'package:assignment/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

String formatDate(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    if (difference.inHours == 0) {
      if (difference.inMinutes == 0) {
        return 'Just now';
      }
      return '${difference.inMinutes}m ago';
    }
    return '${difference.inHours}h ago';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d ago';
  } else {
    // For older dates, show a standard format
    return DateFormat('MMM d, y').format(dateTime);
  }
}
 ToastificationItem customToastification({
    required BuildContext context,
    required ToastificationType type,
    required String title,
    required String description,
    required int seconds,
  }) {
    return toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style:AppStyles.almaraiBold(context).copyWith(fontSize: 14),
      ),
      description: Text(
        description,
        style: AppStyles.almaraiBold(context).copyWith(fontSize: 12),
      ),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      dragToClose: true,
      boxShadow: highModeShadow,
      borderRadius: BorderRadius.circular(12.0),
      autoCloseDuration: Duration(seconds: seconds),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }