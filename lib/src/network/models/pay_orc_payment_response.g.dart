// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcPaymentResponse _$PayOrcPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    PayOrcPaymentResponse(
      status: json['status'] as String,
      statusCode: json['statusCode'] as String,
      message: json['message'] as String,
      pOrderId: (json['pOrderId'] as num).toInt(),
      mOrderId: json['mOrderId'] as String,
      pRequestId: (json['pRequestId'] as num).toInt(),
      orderCreationDate: json['orderCreationDate'] as String,
      amount: json['amount'] as String,
      paymentLink: json['paymentLink'] as String,
      iframeLink: json['iframeLink'] as String,
    );

Map<String, dynamic> _$PayOrcPaymentResponseToJson(
        PayOrcPaymentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'pOrderId': instance.pOrderId,
      'mOrderId': instance.mOrderId,
      'pRequestId': instance.pRequestId,
      'orderCreationDate': instance.orderCreationDate,
      'amount': instance.amount,
      'paymentLink': instance.paymentLink,
      'iframeLink': instance.iframeLink,
    };
