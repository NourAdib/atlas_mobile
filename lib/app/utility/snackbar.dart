import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarService {
  static showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.cancel_outlined,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.greenAccent[400],
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static showNotificationSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blueAccent[400],
      colorText: Colors.white,
      icon: const Icon(
        Icons.notifications_active_outlined,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
