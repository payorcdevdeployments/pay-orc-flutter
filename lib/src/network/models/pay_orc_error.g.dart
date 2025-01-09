// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcError _$PayOrcErrorFromJson(Map<String, dynamic> json) => PayOrcError(
      message: json['data'] as String?,
      status: json['status'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PayOrcErrorToJson(PayOrcError instance) =>
    <String, dynamic>{
      'data': instance.message,
      'status': instance.status,
      'code': instance.code,
    };
