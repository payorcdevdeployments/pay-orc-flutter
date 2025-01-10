// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/src/network/models/pay_orc_payment_transaction_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_pay_orc_platform_interface.dart';
import 'flutter_pay_orc_webview.dart';
import 'helper/config_memory_holder.dart';
import 'helper/flutter_pay_orc_environment.dart';
import 'helper/preference_helper.dart';
import 'network/flutter_pay_orc_client.dart';
import 'network/models/pay_orc_payment_request.dart';

class FlutterPayOrc {
  final PreferencesHelper preferenceHelper;
  ConfigMemoryHolder configMemoryHolder = ConfigMemoryHolder();
  late final FlutterPayOrcClient _client;

  Future<String?> getPlatformVersion() {
    return FlutterPayOrcPlatform.instance.getPlatformVersion();
  }

  FlutterPayOrc._(
      {required this.preferenceHelper, required Environment envType}) {
    configMemoryHolder.envType = envType;
    // Define a map for environment types and their corresponding URLs
    final envUrls = {
      Environment.development: "https://nodeserver.payorc.com/api/v1",
      Environment.staging: "https://nodeserver.payorc.com/api/v1",
      Environment.production: "https://nodeserver.payorc.com/api/v1",
    };
    // Assign the URL or fallback to an empty string
    configMemoryHolder.paymentUrl = envUrls[envType] ?? "";
    _client = FlutterPayOrcClient(
        merchantKey: preferenceHelper.merchantKey,
        merchantSecret: preferenceHelper.merchantSecret,
        paymentBaseUrl: configMemoryHolder.paymentUrl!);
  }

  static FlutterPayOrc? _instance;

  /// Factory constructor for asynchronous initialization
  static Future<FlutterPayOrc> initialize({
    required String merchantKey,
    required String merchantSecret,
    required Environment environment,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final preferenceHelper = PreferencesHelper(preferences);
    preferenceHelper.merchantKey = merchantKey;
    preferenceHelper.merchantSecret = merchantSecret;
    _instance = FlutterPayOrc._(
      preferenceHelper: preferenceHelper,
      envType: environment,
    );
    return _instance!;
  }

  /// Retrieve the singleton instance
  static FlutterPayOrc get instance {
    if (_instance == null) {
      throw Exception(
          'FlutterPayOrc is not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  /// Sets the logged-in user identifier
  String? get userId => configMemoryHolder.userId;

  set userId(String? value) {
    configMemoryHolder.userId = value;
  }

  /// Sets the order id
  String? get orderId => configMemoryHolder.orderId;

  set orderId(String? value) {
    configMemoryHolder.orderId = value;
  }

  /// Sets the order id
  String? get checkOutId => configMemoryHolder.checkOutId;

  set checkOutId(String? value) {
    configMemoryHolder.checkOutId = value;
  }

  /// Returns the current merchant secret (a random GUID assigned to the app running on the device)
  String getMerchantSecret() {
    return preferenceHelper.merchantSecret;
  }

  /// Sets the merchant secret
  void setMerchantSecret(String merchantSecret) {
    preferenceHelper.merchantSecret = merchantSecret;
  }

  /// Returns the current merchant key (a random GUID assigned to the app running on the device)
  String getMerchantKey() {
    return preferenceHelper.merchantKey;
  }

  /// Sets the merchant key
  void setMerchantKey(String merchantKey) {
    preferenceHelper.merchantKey = merchantKey;
  }

  /// Clear preference data
  void clearData() {
    configMemoryHolder = ConfigMemoryHolder();
  }

  Widget createPaymentWithCustomWidget() {
    final paymentUrl =
        instance.configMemoryHolder.payOrcPaymentResponse?.iframeLink;
    return paymentUrl != null && paymentUrl.isNotEmpty
        ? PayOrcWebView(
            paymentUrl: paymentUrl,
          )
        : Text('Payment URL is not available');
  }

  /// To fetch payment transaction
  Future<PayOrcPaymentTransactionResponse?> fetchPaymentTransaction(
      {required String orderId,
      required Function(String? message) errorResult}) async {
    try {
      final response = await _client.fetchPaymentTransaction(orderId);
      configMemoryHolder.payOrcPaymentTransactionResponse = response;
      return response;
    } on HttpException catch (e) {
      errorResult.call(e.message);
      return null;
    }
  }

  /// To create payment with widget
  Future<void> createPaymentWithWidget(
      {required BuildContext context,
      required PayOrcPaymentRequest request,
      required Function(bool loading) onLoadingResult,
      required Function(String? message) errorResult,
      required Function(String? pOrderId) onPopResult}) async {
    try {
      onLoadingResult.call(true);
      final response = await _client.createPayment(request);
      configMemoryHolder.payOrcPaymentResponse = response;
      final paymentUrl =
          instance.configMemoryHolder.payOrcPaymentResponse?.iframeLink;
      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PayOrcWebView(
                  paymentUrl: paymentUrl!,
                  onPopResult: onPopResult,
                )));
      }
    } on HttpException catch (e) {
      errorResult.call(e.message);
    } finally {
      onLoadingResult.call(false);
    }
  }
}
