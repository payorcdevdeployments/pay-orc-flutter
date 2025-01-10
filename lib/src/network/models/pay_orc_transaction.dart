import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_transaction.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class Transaction {
  @JsonKey(name: 'm_order_id')
  final String? mOrderId;

  @JsonKey(name: 'p_order_id')
  final String? pOrderId;

  @JsonKey(name: 'p_request_id')
  final int? pRequestId;

  @JsonKey(name: 'psp_ref_id')
  final String? pspRefId;

  @JsonKey(name: 'psp_txn_id')
  final String? pspTxnId;

  @JsonKey(name: 'transaction_id')
  final int? transactionId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'status_code')
  final String? statusCode;

  @JsonKey(name: 'remark')
  final String? remark;

  @JsonKey(name: 'paydart_category')
  final String? paydartCategory;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'amount')
  final int? amount;

  @JsonKey(name: 'm_customer_id')
  final String? mCustomerId;

  @JsonKey(name: 'psp')
  final String? psp;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'm_payment_token')
  final String? mPaymentToken;

  @JsonKey(name: 'transaction_time')
  final String? transactionTime;

  @JsonKey(name: 'return_url')
  final String? returnUrl;

  @JsonKey(name: 'payment_method_data')
  final PaymentMethodData paymentMethodData;

  @JsonKey(name: 'apm_name')
  final String? apmName;

  @JsonKey(name: 'apm_identifier')
  final String? apmIdentifier;

  @JsonKey(name: 'sub_merchant_identifier')
  final String? subMerchantIdentifier;

  Transaction({
    required this.mOrderId,
    required this.pOrderId,
    required this.pRequestId,
    required this.pspRefId,
    required this.pspTxnId,
    required this.transactionId,
    required this.status,
    required this.statusCode,
    required this.remark,
    required this.paydartCategory,
    required this.currency,
    required this.amount,
    required this.mCustomerId,
    required this.psp,
    required this.paymentMethod,
    required this.mPaymentToken,
    required this.transactionTime,
    required this.returnUrl,
    required this.paymentMethodData,
    required this.apmName,
    required this.apmIdentifier,
    required this.subMerchantIdentifier,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
