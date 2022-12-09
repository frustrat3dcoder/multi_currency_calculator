import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String title, String message) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: Colors.black,
    colorText: Colors.white,
    borderRadius: 4,
    duration: const Duration(seconds: 2),
  );
}
