// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'flutter_pay_orc_platform_interface.dart';
import 'helper/config_memory_holder.dart';
import 'helper/preference_helper.dart';
import 'network/flutter_pay_orc_client.dart';

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
      Environment.test: "https://nodeserver.payorc.com/api/v1",
      Environment.live: "https://nodeserver.payorc.com/api/v1",
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
    required Environment environment,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final preferenceHelper = PreferencesHelper(preferences);
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

  /// To fetch payment transaction
  Future<void> validateMerchantKeys(
      {required PayOrcKeysRequest request,
      required Function(String? message) successResult,
      required Function(String? message) errorResult}) async {
    try {
      final response = await _client.validateMerchantKeys(request);
      if (response.status == PayOrcStatus.success) {
        instance.preferenceHelper.merchantKey = request.merchantKey.toString();
        instance.preferenceHelper.merchantSecret =
            request.merchantSecret.toString();
        successResult.call(response.message);
      } else {
        errorResult.call(response.message);
      }
    } on HttpException catch (e) {
      errorResult.call(e.message);
    }
  }

  /// To fetch payment transaction
  Future<PayOrcPaymentTransactionResponse?> fetchPaymentTransaction(
      {required String orderId,
      required Function(String? message) errorResult}) async {
    try {
      if (instance.preferenceHelper.merchantKey.isEmpty ||
          instance.preferenceHelper.merchantSecret.isEmpty) {
        errorResult.call("Merchant key / secret invalid");
        return null;
      }
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
      if (instance.preferenceHelper.merchantKey.isEmpty ||
          instance.preferenceHelper.merchantSecret.isEmpty) {
        errorResult.call("Merchant key / secret invalid");
        return;
      }
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
