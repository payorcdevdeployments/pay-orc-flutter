// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_payment_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcPaymentTransactionResponse _$PayOrcPaymentTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    PayOrcPaymentTransactionResponse(
      data: json['data'] == null
          ? null
          : PayOrcPaymentTransactionResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PayOrcPaymentTransactionResponseToJson(
        PayOrcPaymentTransactionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
    };

PayOrcPaymentTransactionResponseData
    _$PayOrcPaymentTransactionResponseDataFromJson(Map<String, dynamic> json) =>
        PayOrcPaymentTransactionResponseData(
          mOrderId: json['m_order_id'] as String?,
          pOrderId: json['p_order_id'] as String?,
          pRequestId: (json['p_request_id'] as num?)?.toInt(),
          pspRefId: json['psp_ref_id'] as String?,
          transactionId: json['transaction_id'] as String?,
          pspTxnId: json['psp_txn_id'] as String?,
          transactionDate: json['transaction_date'] as String?,
          status: json['status'] as String?,
          currency: json['currency'] as String?,
          amount: json['amount'] as String?,
          amountCaptured: json['amount_caputred'] as String?,
          psp: json['psp'] as String?,
          paymentMethod: json['payment_method'] as String?,
          mCustomerId: json['m_customer_id'] as String?,
          mPaymentToken: json['m_payment_token'] as String?,
          paymentMethodData: json['payment_method_data'] == null
              ? null
              : PaymentMethodData.fromJson(
                  json['payment_method_data'] as Map<String, dynamic>),
          apmName: json['apm_name'] as String?,
          apmIdentifier: json['apm_identifier'] as String?,
          subMerchantIdentifier: json['sub_merchant_identifier'] as String?,
          transactionHistory: json['transaction_history'] as List<dynamic>?,
          channel: json['channel'] as String?,
        );

Map<String, dynamic> _$PayOrcPaymentTransactionResponseDataToJson(
        PayOrcPaymentTransactionResponseData instance) =>
    <String, dynamic>{
      'm_order_id': instance.mOrderId,
      'p_order_id': instance.pOrderId,
      'p_request_id': instance.pRequestId,
      'psp_ref_id': instance.pspRefId,
      'transaction_id': instance.transactionId,
      'psp_txn_id': instance.pspTxnId,
      'transaction_date': instance.transactionDate,
      'status': instance.status,
      'currency': instance.currency,
      'amount': instance.amount,
      'amount_caputred': instance.amountCaptured,
      'psp': instance.psp,
      'payment_method': instance.paymentMethod,
      'm_customer_id': instance.mCustomerId,
      'm_payment_token': instance.mPaymentToken,
      'payment_method_data': instance.paymentMethodData,
      'apm_name': instance.apmName,
      'apm_identifier': instance.apmIdentifier,
      'sub_merchant_identifier': instance.subMerchantIdentifier,
      'transaction_history': instance.transactionHistory,
      'channel': instance.channel,
    };

PaymentMethodData _$PaymentMethodDataFromJson(Map<String, dynamic> json) =>
    PaymentMethodData(
      scheme: json['scheme'] as String?,
      cardCountry: json['card_country'] as String?,
      cardType: json['card_type'] as String?,
      maskedPan: json['masked_pan'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDataToJson(PaymentMethodData instance) =>
    <String, dynamic>{
      'scheme': instance.scheme,
      'card_country': instance.cardCountry,
      'card_type': instance.cardType,
      'masked_pan': instance.maskedPan,
    };
