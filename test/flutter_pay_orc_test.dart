import 'package:flutter_pay_orc/helper/flutter_pay_orc_environment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:flutter_pay_orc/flutter_pay_orc_platform_interface.dart';
import 'package:flutter_pay_orc/flutter_pay_orc_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPayOrcPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPayOrcPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPayOrcPlatform initialPlatform = FlutterPayOrcPlatform.instance;

  test('$MethodChannelFlutterPayOrc is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPayOrc>());
  });

  test('getPlatformVersion', () async {
    var flutterPayOrcPlugin = FlutterPayOrc.initialize(
      clientId: 'your-api-key',
      merchantId: 'your-merchant-id',
      environment: Environment.development, // Switch to Environment.production for live
    );
    MockFlutterPayOrcPlatform fakePlatform = MockFlutterPayOrcPlatform();
    FlutterPayOrcPlatform.instance = fakePlatform;

    expect(await flutterPayOrcPlugin.getPlatformVersion(), '42');
  });
}
