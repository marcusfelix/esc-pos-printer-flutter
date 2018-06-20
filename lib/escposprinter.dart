import 'dart:async';

import 'package:flutter/services.dart';

class Escposprinter {
  static const MethodChannel _channel =
      const MethodChannel('escposprinter');

  static Future<List> get getUSBDeviceList async {
    final List devices = await _channel.invokeMethod('getUSBDeviceList');
    return devices;
  }

  static Future<bool> connectPrinter(int vendor, int product) async {
    Map<String, dynamic> params = {"vendor": vendor, "product": product};
    final bool returned = await _channel.invokeMethod('connectPrinter', params);
    return returned;
  }

  static Future<bool> get closeConn async {
    final bool returned = await _channel.invokeMethod('closeConn');
    return returned;
  }

  static Future<bool> printText(String text) async {
    Map<String, dynamic> params = {"text": text};
    final bool returned = await _channel.invokeMethod('printText', params);
    return returned;
  }

  static Future<bool> printRawData(String text) async {
    Map<String, dynamic> params = {"text": text};
    final bool returned = await _channel.invokeMethod('printRawData', params);
    return returned;
  }
}
