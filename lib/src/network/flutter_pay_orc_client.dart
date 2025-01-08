import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:flutter_pay_orc/src/helper/api_paths.dart';

import 'models/pay_orc_payment_request.dart';
import 'models/pay_orc_payment_response.dart';

class FlutterPayOrcClient {
  final Dio _dio;

  /// Dio client initialisation
  FlutterPayOrcClient(
      {required String merchantKey,
      required String merchantSecret,
      required String paymentBaseUrl})
      : _dio = Dio(BaseOptions(
            baseUrl: paymentBaseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'merchant-key': merchantKey,
              'merchant-secret': merchantSecret,
              'Content-Type': 'application/json',
            })) {
    // Add logging interceptor
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
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
        throw Exception('Failed to create order');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        throw Exception('Payment failed: ${e.response?.data}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }
}
