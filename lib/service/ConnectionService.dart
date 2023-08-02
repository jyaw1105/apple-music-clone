import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

class ConnectionService {
  static Future<bool> checkConnection() async {
    if (kIsWeb) return true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      log('not connected');
    }
    return false;
  }
}
