// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcError _$PayOrcErrorFromJson(Map<String, dynamic> json) => PayOrcError(
      message: json['message'] as String?,
      status: json['status'] as String?,
      code: PayOrcError._fromJson(json['code']),
    );

Map<String, dynamic> _$PayOrcErrorToJson(PayOrcError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
    };
