import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_error.g.dart';

@JsonSerializable()
class PayOrcError {
  final String? message;
  final String? status;
  final int? code;

  PayOrcError({
    this.message,
    this.status,
    this.code,
  });

  factory PayOrcError.fromJson(Map<String, dynamic> json) =>
      _$PayOrcErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcErrorToJson(this);
}
