// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcPaymentResponse _$PayOrcPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    PayOrcPaymentResponse(
      status: json['status'] as String,
      statusCode: json['status_code'] as String,
      message: json['message'] as String,
      pOrderId: (json['p_order_id'] as num).toInt(),
      mOrderId: json['m_order_id'] as String,
      pRequestId: (json['p_request_id'] as num).toInt(),
      orderCreationDate: json['order_creation_date'] as String,
      amount: json['amount'] as String,
      paymentLink: json['payment_link'] as String,
      iframeLink: json['iframe_link'] as String,
    );

Map<String, dynamic> _$PayOrcPaymentResponseToJson(
        PayOrcPaymentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'p_order_id': instance.pOrderId,
      'm_order_id': instance.mOrderId,
      'p_request_id': instance.pRequestId,
      'order_creation_date': instance.orderCreationDate,
      'amount': instance.amount,
      'payment_link': instance.paymentLink,
      'iframe_link': instance.iframeLink,
    };
