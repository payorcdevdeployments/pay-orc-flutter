import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_payment_transaction_response.g.dart';

@JsonSerializable()
class PayOrcPaymentTransactionResponse {
  @JsonKey(name: 'data')
  final PayOrcPaymentTransactionResponseData? data;
  final String? message;
  final String? status;
  final String? code;

  PayOrcPaymentTransactionResponse({
    this.data,
    this.message,
    this.status,
    this.code,
  });

  factory PayOrcPaymentTransactionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PayOrcPaymentTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PayOrcPaymentTransactionResponseToJson(this);
}

@JsonSerializable()
class PayOrcPaymentTransactionResponseData {
  @JsonKey(name: 'm_order_id')
  final String? mOrderId;
  @JsonKey(name: 'p_order_id')
  final String? pOrderId;
  @JsonKey(name: 'p_request_id')
  final int? pRequestId;
  @JsonKey(name: 'psp_ref_id')
  final String? pspRefId;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  @JsonKey(name: 'psp_txn_id')
  final String? pspTxnId;
  @JsonKey(name: 'transaction_date')
  final String? transactionDate;
  final String? status;
  final String? currency;
  final String? amount;
  @JsonKey(name: 'amount_caputred')
  final String? amountCaptured;
  final String? psp;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'm_customer_id')
  final String? mCustomerId;
  @JsonKey(name: 'm_payment_token')
  final String? mPaymentToken;
  @JsonKey(name: 'payment_method_data')
  final PaymentMethodData? paymentMethodData;
  @JsonKey(name: 'apm_name')
  final String? apmName;
  @JsonKey(name: 'apm_identifier')
  final String? apmIdentifier;
  @JsonKey(name: 'sub_merchant_identifier')
  final String? subMerchantIdentifier;
  @JsonKey(name: 'transaction_history')
  final List<dynamic>? transactionHistory;
  final String? channel;

  PayOrcPaymentTransactionResponseData({
    this.mOrderId,
    this.pOrderId,
    this.pRequestId,
    this.pspRefId,
    this.transactionId,
    this.pspTxnId,
    this.transactionDate,
    this.status,
    this.currency,
    this.amount,
    this.amountCaptured,
    this.psp,
    this.paymentMethod,
    this.mCustomerId,
    this.mPaymentToken,
    this.paymentMethodData,
    this.apmName,
    this.apmIdentifier,
    this.subMerchantIdentifier,
    this.transactionHistory,
    this.channel,
  });

  factory PayOrcPaymentTransactionResponseData.fromJson(
          Map<String, dynamic> json) =>
      _$PayOrcPaymentTransactionResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PayOrcPaymentTransactionResponseDataToJson(this);
}

@JsonSerializable()
class PaymentMethodData {
  final String? scheme;
  @JsonKey(name: 'card_country')
  final String? cardCountry;
  @JsonKey(name: 'card_type')
  final String? cardType;
  @JsonKey(name: 'masked_pan')
  final String? maskedPan;

  PaymentMethodData({
    this.scheme,
    this.cardCountry,
    this.cardType,
    this.maskedPan,
  });

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDataToJson(this);
}
