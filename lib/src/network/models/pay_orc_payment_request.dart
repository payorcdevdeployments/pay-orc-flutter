import 'package:json_annotation/json_annotation.dart';
part 'pay_orc_payment_request.g.dart';

@JsonSerializable()
class PayOrcPaymentRequest {
  final Data data;

  PayOrcPaymentRequest({required this.data});

  factory PayOrcPaymentRequest.fromJson(Map<String, dynamic> json) => _$PayOrcPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcPaymentRequestToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'class')
  final String className;
  final String action;
  final String captureMethod;
  final String paymentToken;
  final OrderDetails orderDetails;
  final CustomerDetails customerDetails;
  final BillingDetails billingDetails;
  final ShippingDetails shippingDetails;
  final Urls urls;

  Data({
    required this.className,
    required this.action,
    required this.captureMethod,
    required this.paymentToken,
    required this.orderDetails,
    required this.customerDetails,
    required this.billingDetails,
    required this.shippingDetails,
    required this.urls,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class OrderDetails {
  final String mOrderId;
  final String amount;
  final String convenienceFee;
  final String quantity;
  final String currency;
  final String description;

  OrderDetails({
    required this.mOrderId,
    required this.amount,
    required this.convenienceFee,
    required this.quantity,
    required this.currency,
    required this.description,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}

@JsonSerializable()
class CustomerDetails {
  final String mCustomerId;
  final String name;
  final String email;
  final String mobile;
  final String code;

  CustomerDetails({
    required this.mCustomerId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.code,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class BillingDetails {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String province;
  final String country;
  final String pin;

  BillingDetails({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.province,
    required this.country,
    required this.pin,
  });

  factory BillingDetails.fromJson(Map<String, dynamic> json) =>
      _$BillingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BillingDetailsToJson(this);
}

@JsonSerializable()
class ShippingDetails {
  final String shippingName;
  final String shippingEmail;
  final String shippingCode;
  final String shippingMobile;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String province;
  final String country;
  final String pin;
  final String locationPin;
  final String shippingCurrency;
  final String shippingAmount;

  ShippingDetails({
    required this.shippingName,
    required this.shippingEmail,
    required this.shippingCode,
    required this.shippingMobile,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.province,
    required this.country,
    required this.pin,
    required this.locationPin,
    required this.shippingCurrency,
    required this.shippingAmount,
  });

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      _$ShippingDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingDetailsToJson(this);
}

@JsonSerializable()
class Urls {
  final String success;
  final String cancel;
  final String failure;

  Urls({
    required this.success,
    required this.cancel,
    required this.failure,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
