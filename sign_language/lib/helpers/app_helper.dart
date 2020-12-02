import 'package:flutter/material.dart';

class AppHelper {
  static void log(String methodName, String message) {
    debugPrint("{$methodName} {$message}");
  }
}
