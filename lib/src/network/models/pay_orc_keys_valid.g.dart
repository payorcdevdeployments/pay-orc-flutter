// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_keys_valid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcKeysValid _$PayOrcKeysValidFromJson(Map<String, dynamic> json) =>
    PayOrcKeysValid(
      message: json['message'] as String?,
      status: $enumDecodeNullable(_$PayOrcStatusEnumMap, json['status']),
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PayOrcKeysValidToJson(PayOrcKeysValid instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': _$PayOrcStatusEnumMap[instance.status],
      'code': instance.code,
    };

const _$PayOrcStatusEnumMap = {
  PayOrcStatus.success: 'success',
  PayOrcStatus.fail: 'fail',
};
