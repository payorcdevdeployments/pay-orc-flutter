import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_transaction.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class Transaction {

  @JsonKey(name: 'p_order_id')
  final String? pOrderId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'status_code')
  final String? statusCode;

  @JsonKey(name: 'remark')
  final String? remark;

  Transaction({
    required this.pOrderId,
    required this.status,
    required this.statusCode,
    required this.remark,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
