// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      mOrderId: json['m_order_id'] as String?,
      pOrderId: json['p_order_id'] as String?,
      pRequestId: (json['p_request_id'] as num?)?.toInt(),
      pspRefId: json['psp_ref_id'] as String?,
      pspTxnId: json['psp_txn_id'] as String?,
      transactionId: (json['transaction_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      statusCode: json['status_code'] as String?,
      remark: json['remark'] as String?,
      paydartCategory: json['paydart_category'] as String?,
      currency: json['currency'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      mCustomerId: json['m_customer_id'] as String?,
      psp: json['psp'] as String?,
      paymentMethod: json['payment_method'] as String?,
      mPaymentToken: json['m_payment_token'] as String?,
      transactionTime: json['transaction_time'] as String?,
      returnUrl: json['return_url'] as String?,
      paymentMethodData: PaymentMethodData.fromJson(
          json['payment_method_data'] as Map<String, dynamic>),
      apmName: json['apm_name'] as String?,
      apmIdentifier: json['apm_identifier'] as String?,
      subMerchantIdentifier: json['sub_merchant_identifier'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'm_order_id': instance.mOrderId,
      'p_order_id': instance.pOrderId,
      'p_request_id': instance.pRequestId,
      'psp_ref_id': instance.pspRefId,
      'psp_txn_id': instance.pspTxnId,
      'transaction_id': instance.transactionId,
      'status': instance.status,
      'status_code': instance.statusCode,
      'remark': instance.remark,
      'paydart_category': instance.paydartCategory,
      'currency': instance.currency,
      'amount': instance.amount,
      'm_customer_id': instance.mCustomerId,
      'psp': instance.psp,
      'payment_method': instance.paymentMethod,
      'm_payment_token': instance.mPaymentToken,
      'transaction_time': instance.transactionTime,
      'return_url': instance.returnUrl,
      'payment_method_data': instance.paymentMethodData.toJson(),
      'apm_name': instance.apmName,
      'apm_identifier': instance.apmIdentifier,
      'sub_merchant_identifier': instance.subMerchantIdentifier,
    };
