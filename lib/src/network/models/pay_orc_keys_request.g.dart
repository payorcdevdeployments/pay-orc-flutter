// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_keys_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcKeysRequest _$PayOrcKeysRequestFromJson(Map<String, dynamic> json) =>
    PayOrcKeysRequest(
      merchantKey: json['merchant_key'] as String?,
      merchantSecret: json['merchant_secret'] as String?,
      env: $enumDecodeNullable(_$EnvironmentEnumMap, json['env']),
    );

Map<String, dynamic> _$PayOrcKeysRequestToJson(PayOrcKeysRequest instance) =>
    <String, dynamic>{
      'merchant_key': instance.merchantKey,
      'merchant_secret': instance.merchantSecret,
      'env': _$EnvironmentEnumMap[instance.env],
    };

const _$EnvironmentEnumMap = {
  Environment.test: 'test',
  Environment.live: 'live',
};
