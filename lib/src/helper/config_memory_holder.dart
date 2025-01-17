import 'package:flutter_pay_orc/flutter_pay_orc.dart';

class ConfigMemoryHolder {
  /// The user ID.
  String? userId;

  /// The order ID.
  String? orderId;

  /// The checkout ID.
  String? checkOutId;

  /// The Environment Type.
  Environment? environment;

  /// The payment url.
  String? baseUrl;

  /// The payment object ref.
  PayOrcPaymentResponse? payOrcPaymentResponse;

  /// The payment object ref.
  PayOrcPaymentTransactionResponse? payOrcPaymentTransactionResponse;

  /// Merchant keys valid ref
  PayOrcKeysValid? payOrcKeysValid;

  ConfigMemoryHolder();
}
