import 'dart:async';

import 'package:flutter/services.dart';

enum ImageSource {
  gallery
}

class CirrusReadQr {
  static const MethodChannel _channel = const MethodChannel('cirrus_read_qr');

  static Future<dynamic> pickImage(){
    return _channel.invokeMethod('pickImage');
  }
}
