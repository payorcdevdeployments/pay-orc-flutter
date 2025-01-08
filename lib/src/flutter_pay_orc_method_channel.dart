import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pay_orc_platform_interface.dart';

/// An implementation of [FlutterPayOrcPlatform] that uses method channels.
class MethodChannelFlutterPayOrc extends FlutterPayOrcPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pay_orc');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
