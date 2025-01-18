// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:flutter_pay_orc/src/helper/api_paths.dart';
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
      {required this.preferenceHelper, required Environment environment}) {
    configMemoryHolder.environment = environment;
    // Define a map for environment types and their corresponding URLs
    final envUrls = {
      Environment.test: "https://nodeserver.payorc.com/api/v1",
      Environment.live: "https://nodeserver.payorc.com/api/v1",
    };
    // Assign the URL or fallback to an empty string
    configMemoryHolder.baseUrl = envUrls[environment] ?? "";
    _client = FlutterPayOrcClient(
        paymentBaseUrl: configMemoryHolder.baseUrl!,
        preferenceHelper: preferenceHelper);
  }

  static FlutterPayOrc? _instance;

  /// Factory constructor for asynchronous initialization
  static Future<FlutterPayOrc> initialize({
    required Environment environment,
    required String merchantKey,
    required String merchantSecret,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final preferenceHelper = PreferencesHelper(preferences);
    await preferenceHelper.saveMerchantKey(merchantKey);
    await preferenceHelper.saveMerchantSecret(merchantSecret);
    _instance = FlutterPayOrc._(
      preferenceHelper: preferenceHelper,
      environment: environment,
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
  Future<String?> getMerchantSecret() async {
    return await preferenceHelper.getMerchantSecret();
  }

  /// Returns the current merchant key (a random GUID assigned to the app running on the device)
  Future<String?> getMerchantKey() async {
    return await preferenceHelper.getMerchantKey();
  }

  /// Clear preference data
  Future<void> clearData() async {
    configMemoryHolder.userId = null;
    configMemoryHolder.orderId = null;
    configMemoryHolder.checkOutId = null;
    configMemoryHolder.payOrcPaymentResponse = null;
    configMemoryHolder.payOrcPaymentTransactionResponse = null;
    configMemoryHolder.payOrcKeysValid = null;
  }

  /// To fetch payment transaction
  Future<PayOrcPaymentTransactionResponse?> fetchPaymentTransaction(
      {required String orderId,
      required Function(bool loading) onLoadingResult,
      required Function(String? message) errorResult}) async {
    try {
      onLoadingResult.call(true);
      if (configMemoryHolder.payOrcKeysValid?.status == PayOrcStatus.success) {
        final response = await _client.fetchPaymentTransaction(orderId);
        configMemoryHolder.payOrcPaymentTransactionResponse = response;
        return response;
      } else {
        final merchantKey = await preferenceHelper.getMerchantKey();
        final merchantSecret = await preferenceHelper.getMerchantSecret();

        final validate = await _client.validateMerchantKeys(PayOrcKeysRequest(
            merchantKey: merchantKey,
            merchantSecret: merchantSecret,
            env: configMemoryHolder.environment));

        if (validate.status == PayOrcStatus.success) {
          configMemoryHolder.payOrcKeysValid = validate;
          final response = await _client.fetchPaymentTransaction(orderId);
          configMemoryHolder.payOrcPaymentTransactionResponse = response;
          return response;
        } else {
          configMemoryHolder.payOrcKeysValid = null;
          errorResult.call(validate.message ?? "Merchant key / secret invalid");
          return null;
        }
      }
    } on HttpException catch (e) {
      if (e.uri?.path.contains(ApiPaths.URL_CHECK_KEYS) == true) {
        configMemoryHolder.payOrcKeysValid = null;
      }
      errorResult.call(e.message);
      return null;
    } finally {
      onLoadingResult.call(false);
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
      await clearData();

      onLoadingResult.call(true);
      if (configMemoryHolder.payOrcKeysValid?.status == PayOrcStatus.success) {
        final response = await _client.createPayment(request);
        configMemoryHolder.payOrcPaymentResponse = response;
        final paymentUrl = configMemoryHolder.payOrcPaymentResponse?.iframeLink;
        if (context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PayOrcWebView(
                    paymentUrl: paymentUrl!,
                    onPopResult: onPopResult,
                  )));
        }
      } else {
        final merchantKey = await preferenceHelper.getMerchantKey();
        final merchantSecret = await preferenceHelper.getMerchantSecret();

        final validate = await _client.validateMerchantKeys(PayOrcKeysRequest(
            merchantKey: merchantKey,
            merchantSecret: merchantSecret,
            env: configMemoryHolder.environment));

        if (validate.status == PayOrcStatus.success) {
          final response = await _client.createPayment(request);
          configMemoryHolder.payOrcPaymentResponse = response;
          final paymentUrl =
              configMemoryHolder.payOrcPaymentResponse?.iframeLink;
          if (context.mounted) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PayOrcWebView(
                      paymentUrl: paymentUrl!,
                      onPopResult: onPopResult,
                    )));
          }
        } else {
          configMemoryHolder.payOrcKeysValid = null;
          errorResult.call(validate.message ?? "Merchant key / secret invalid");
          return;
        }
      }
    } on HttpException catch (e) {
      if (e.uri?.path.contains(ApiPaths.URL_CHECK_KEYS) == true) {
        configMemoryHolder.payOrcKeysValid = null;
      }
      errorResult.call(e.message);
    } finally {
      onLoadingResult.call(false);
    }
  }
}
