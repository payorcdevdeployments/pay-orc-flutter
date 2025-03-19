import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'payorc_flutter_method_channel.dart';

abstract class PayOrcFlutterPlatform extends PlatformInterface {
  /// Constructs a PayOrcFlutterPlatform.
  PayOrcFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PayOrcFlutterPlatform _instance = MethodChannelPayOrcFlutter();

  /// The default instance of [PayOrcFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPayOrcFlutter].
  static PayOrcFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PayOrcFlutterPlatform] when
  /// they register themselves.
  static set instance(PayOrcFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
