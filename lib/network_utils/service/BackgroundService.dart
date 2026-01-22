

import 'package:flutter/services.dart';

class BackgroundService {
  static const MethodChannel _channel = MethodChannel('background_service');

  static Future<String> startService() async {
    try {
      final String result = await _channel.invokeMethod('startService');
      return result;
    } on PlatformException catch (e) {
      return "Failed to start service: '${e.message}'.";
    }
  }
}