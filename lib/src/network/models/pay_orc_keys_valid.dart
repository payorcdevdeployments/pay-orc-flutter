import 'package:flutter_pay_orc/src/network/enum/pay.orc.status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_keys_valid.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class PayOrcKeysValid {
  final String? message;
  final PayOrcStatus? status;
  final String? code;

  PayOrcKeysValid({
    this.message,
    this.status,
    this.code,
  });

  factory PayOrcKeysValid.fromJson(Map<String, dynamic> json) =>
      _$PayOrcKeysValidFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcKeysValidToJson(this);
}
