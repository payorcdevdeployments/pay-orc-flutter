import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pay_orc_flutter_platform_interface.dart';

/// An implementation of [FlutterPayOrcPlatform] that uses method channels.
class MethodChannelFlutterPayOrc extends FlutterPayOrcPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pay_orc_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
