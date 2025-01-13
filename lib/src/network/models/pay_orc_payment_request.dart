import 'package:json_annotation/json_annotation.dart';

part 'pay_orc_payment_request.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class PayOrcPaymentRequest {
  @JsonKey(name: 'data')
  final Data data;

  PayOrcPaymentRequest({required this.data});

  factory PayOrcPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PayOrcPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayOrcPaymentRequestToJson(this);
}

@JsonSerializable(createToJson: true, explicitToJson: true)
class Data {
  @JsonKey(name: 'class')
  final String className;
  @JsonKey(name: 'action')
  final String action;
  @JsonKey(name: 'capture_method')
  final String captureMethod;
  @JsonKey(name: 'payment_token')
  final String paymentToken;
  @JsonKey(name: 'order_details')
  final OrderDetails orderDetails;
  @JsonKey(name: 'customer_details')
  final CustomerDetails customerDetails;
  @JsonKey(name: 'billing_details')
  final BillingDetails billingDetails;
  @JsonKey(name: 'shipping_details')
  final ShippingDetails shippingDetails;
  @JsonKey(name: 'urls')
  final Urls urls;
  final List<Map<String, dynamic>> parameters;
  final List<Map<String, dynamic>> customData;

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
    required this.parameters,
    required this.customData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(createToJson: true, explicitToJson: true)
class OrderDetails {
  @JsonKey(name: 'm_order_id')
  final String mOrderId;
  @JsonKey(name: 'amount')
  final String amount;
  @JsonKey(name: 'convenience_fee')
  final String convenienceFee;
  @JsonKey(name: 'quantity')
  final String quantity;
  @JsonKey(name: 'currency')
  final String currency;
  @JsonKey(name: 'description')
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

@JsonSerializable(createToJson: true, explicitToJson: true)
class CustomerDetails {
  @JsonKey(name: 'm_customer_id')
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

@JsonSerializable(createToJson: true, explicitToJson: true)
class BillingDetails {
  @JsonKey(name: 'address_line1')
  final String addressLine1;
  @JsonKey(name: 'address_line2')
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

@JsonSerializable(createToJson: true, explicitToJson: true)
class ShippingDetails {
  @JsonKey(name: 'shipping_name')
  final String shippingName;
  @JsonKey(name: 'shipping_email')
  final String shippingEmail;
  @JsonKey(name: 'shipping_code')
  final String shippingCode;
  @JsonKey(name: 'shipping_mobile')
  final String shippingMobile;
  @JsonKey(name: 'address_line1')
  final String addressLine1;
  @JsonKey(name: 'address_line2')
  final String addressLine2;
  final String city;
  final String province;
  final String country;
  final String pin;
  @JsonKey(name: 'location_pin')
  final String locationPin;
  @JsonKey(name: 'shipping_currency')
  final String shippingCurrency;
  @JsonKey(name: 'shipping_amount')
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

@JsonSerializable(createToJson: true, explicitToJson: true)
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
