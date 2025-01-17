import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pay_orc/src/helper/api_paths.dart';
import 'package:flutter_pay_orc/src/helper/preference_helper.dart';
import 'package:flutter_pay_orc/src/network/models/pay_orc_error.dart';
import 'package:flutter_pay_orc/src/network/models/pay_orc_keys_request.dart';
import 'package:flutter_pay_orc/src/network/models/pay_orc_keys_valid.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'models/pay_orc_payment_request.dart';
import 'models/pay_orc_payment_response.dart';
import 'models/pay_orc_payment_transaction_response.dart';

class FlutterPayOrcClient {
  final Dio _dio;

  final PreferencesHelper preferenceHelper;

  /// Dio client initialisation
  FlutterPayOrcClient(
      {required String paymentBaseUrl, required this.preferenceHelper})
      : _dio = Dio(BaseOptions(
            baseUrl: paymentBaseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {
              'Content-Type': 'application/json',
            })) {
    // Add logging interceptor
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: kDebugMode,
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: kDebugMode,
      error: kDebugMode,
      compact: kDebugMode,
    ));

    _registerInterceptor();
  }

  void _registerInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final merchantKey = await preferenceHelper.getMerchantKey();
        final merchantSecret = await preferenceHelper.getMerchantSecret();

        if (merchantKey != null && merchantSecret != null) {
          final Map<String, String> headers = <String, String>{
            'merchant-key': merchantKey,
            'merchant-secret': merchantSecret,
          };
          options.headers.addAll(headers);
        }
        handler.next(options);
      }, onResponse:
          (Response<dynamic> response, ResponseInterceptorHandler handler) {
        return handler.next(response); // continue
      }, onError: (DioException e, ErrorInterceptorHandler handler) {
        return handler.next(e); //continue
      }),
    );
  }

  /// Api to validate merchant keys
  Future<PayOrcKeysValid> validateMerchantKeys(
      PayOrcKeysRequest request) async {
    try {
      Map requestData = request.toJson();
      final response = await _dio.post(
        ApiPaths.URL_CHECK_KEYS,
        data: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        return PayOrcKeysValid.fromJson(response.data);
      } else {
        throw HttpException('Failed to validate merchant keys',
            uri: Uri.parse(ApiPaths.URL_CHECK_KEYS));
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        final payOrcError = PayOrcError.fromJson(e.response!.data);
        throw HttpException('${payOrcError.message}',
            uri: Uri.parse(ApiPaths.URL_CHECK_KEYS));
      } else {
        throw HttpException('${e.message}',
            uri: Uri.parse(ApiPaths.URL_CHECK_KEYS));
      }
    }
  }

  /// Api to create payment
  Future<PayOrcPaymentResponse> createPayment(
      PayOrcPaymentRequest request) async {
    try {
      Map requestData = request.toJson();
      final response = await _dio.post(
        ApiPaths.URL_CREATE_PAYMENT,
        data: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        return PayOrcPaymentResponse.fromJson(response.data);
      } else {
        throw HttpException('Failed to create order request',
            uri: Uri.parse(ApiPaths.URL_CREATE_PAYMENT));
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        final payOrcError = PayOrcError.fromJson(e.response!.data);
        throw HttpException('${payOrcError.message}',
            uri: Uri.parse(ApiPaths.URL_CREATE_PAYMENT));
      } else {
        throw HttpException('${e.message}',
            uri: Uri.parse(ApiPaths.URL_CREATE_PAYMENT));
      }
    }
  }

  /// Api to fetch payment transaction
  Future<PayOrcPaymentTransactionResponse> fetchPaymentTransaction(
      String orderId) async {
    try {
      final response = await _dio.get(
        ApiPaths.URL_PAYMENT_TRANSACTION,
        queryParameters: {'p_order_id': orderId},
      );
      if (response.statusCode == 200) {
        return PayOrcPaymentTransactionResponse.fromJson(response.data);
      } else {
        throw HttpException('Failed to fetch transaction details',
            uri: Uri.parse(ApiPaths.URL_PAYMENT_TRANSACTION));
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        final payOrcError = PayOrcError.fromJson(e.response!.data);
        throw HttpException('${payOrcError.message}',
            uri: Uri.parse(ApiPaths.URL_PAYMENT_TRANSACTION));
      } else {
        throw HttpException('${e.message}',
            uri: Uri.parse(ApiPaths.URL_PAYMENT_TRANSACTION));
      }
    }
  }
}
