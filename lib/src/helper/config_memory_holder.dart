
import 'package:flutter_pay_orc/flutter_pay_orc.dart';

import 'flutter_pay_orc_environment.dart';

class ConfigMemoryHolder {

  /// The user ID.
  String? userId;

  /// The order ID.
  String? orderId;

  /// The checkout ID.
  String? checkOutId;

  /// The Environment Type.
  Environment? envType;

  /// The payment url.
  String? paymentUrl;

  /// The payment object ref.
  PayOrcPaymentResponse? payOrcPaymentResponse;

  /// The payment object ref.
  PayOrcPaymentTransactionResponse? payOrcPaymentTransactionResponse;

  ConfigMemoryHolder();
}