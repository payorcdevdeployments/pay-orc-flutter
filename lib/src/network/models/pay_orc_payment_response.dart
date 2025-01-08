import 'package:json_annotation/json_annotation.dart';
part 'pay_orc_payment_response.g.dart';

@JsonSerializable()
class PayOrcPaymentResponse {
  final String status;
  final String statusCode;
  final String message;
  final int pOrderId;
  final String mOrderId;
  final int pRequestId;
  final String orderCreationDate;
  final String amount;
  final String paymentLink;
  final String iframeLink;

  PayOrcPaymentResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.pOrderId,
    required this.mOrderId,
    required this.pRequestId,
    required this.orderCreationDate,
    required this.amount,
    required this.paymentLink,
    required this.iframeLink,
  });

  factory PayOrcPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PayOrcPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcPaymentResponseToJson(this);
}
