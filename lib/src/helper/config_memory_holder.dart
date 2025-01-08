
import 'package:flutter_pay_orc/src/network/models/pay_orc_payment_response.dart';

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

  ConfigMemoryHolder();
}