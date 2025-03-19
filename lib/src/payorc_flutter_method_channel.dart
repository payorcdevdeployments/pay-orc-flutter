import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'payorc_flutter_platform_interface.dart';

/// An implementation of [PayOrcFlutterPlatform] that uses method channels.
class MethodChannelPayOrcFlutter extends PayOrcFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('payorc_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
