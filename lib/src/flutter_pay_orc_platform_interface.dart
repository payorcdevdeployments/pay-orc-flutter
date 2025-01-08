import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pay_orc_method_channel.dart';

abstract class FlutterPayOrcPlatform extends PlatformInterface {
  /// Constructs a FlutterPayOrcPlatform.
  FlutterPayOrcPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPayOrcPlatform _instance = MethodChannelFlutterPayOrc();

  /// The default instance of [FlutterPayOrcPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPayOrc].
  static FlutterPayOrcPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPayOrcPlatform] when
  /// they register themselves.
  static set instance(FlutterPayOrcPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
