// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      pOrderId: json['p_order_id'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'p_order_id': instance.pOrderId,
      'status': instance.status,
      'status_code': instance.statusCode,
      'remark': instance.remark,
    };
