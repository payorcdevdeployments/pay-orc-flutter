import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_payment_response.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class PayOrcPaymentResponse {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'status_code')
  final String statusCode;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'p_order_id')
  final int pOrderId;
  @JsonKey(name: 'm_order_id')
  final String mOrderId;
  @JsonKey(name: 'p_request_id')
  final int pRequestId;
  @JsonKey(name: 'order_creation_date')
  final String orderCreationDate;
  @JsonKey(name: 'amount')
  final String amount;
  @JsonKey(name: 'payment_link')
  final String paymentLink;
  @JsonKey(name: 'iframe_link')
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
