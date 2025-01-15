import 'package:flutter_pay_orc/src/helper/flutter_pay_orc_environment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_keys_request.g.dart';

@JsonSerializable()
class PayOrcKeysRequest {
  @JsonKey(name: 'merchant_key')
  final String? merchantKey;
  @JsonKey(name: 'merchant_secret')
  final String? merchantSecret;
  final Environment? env;

  PayOrcKeysRequest({
    this.merchantKey,
    this.merchantSecret,
    this.env,
  });

  factory PayOrcKeysRequest.fromJson(Map<String, dynamic> json) =>
      _$PayOrcKeysRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcKeysRequestToJson(this);
}
