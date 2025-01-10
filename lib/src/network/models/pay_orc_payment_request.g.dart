// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_orc_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOrcPaymentRequest _$PayOrcPaymentRequestFromJson(
        Map<String, dynamic> json) =>
    PayOrcPaymentRequest(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayOrcPaymentRequestToJson(
        PayOrcPaymentRequest instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      className: json['class'] as String,
      action: json['action'] as String,
      captureMethod: json['capture_method'] as String,
      paymentToken: json['payment_token'] as String,
      orderDetails:
          OrderDetails.fromJson(json['order_details'] as Map<String, dynamic>),
      customerDetails: CustomerDetails.fromJson(
          json['customer_details'] as Map<String, dynamic>),
      billingDetails: BillingDetails.fromJson(
          json['billing_details'] as Map<String, dynamic>),
      shippingDetails: ShippingDetails.fromJson(
          json['shipping_details'] as Map<String, dynamic>),
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'class': instance.className,
      'action': instance.action,
      'capture_method': instance.captureMethod,
      'payment_token': instance.paymentToken,
      'order_details': instance.orderDetails.toJson(),
      'customer_details': instance.customerDetails.toJson(),
      'billing_details': instance.billingDetails.toJson(),
      'shipping_details': instance.shippingDetails.toJson(),
      'urls': instance.urls.toJson(),
    };

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
      mOrderId: json['m_order_id'] as String,
      amount: json['amount'] as String,
      convenienceFee: json['convenience_fee'] as String,
      quantity: json['quantity'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      'm_order_id': instance.mOrderId,
      'amount': instance.amount,
      'convenience_fee': instance.convenienceFee,
      'quantity': instance.quantity,
      'currency': instance.currency,
      'description': instance.description,
    };

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) =>
    CustomerDetails(
      mCustomerId: json['m_customer_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'm_customer_id': instance.mCustomerId,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'code': instance.code,
    };

BillingDetails _$BillingDetailsFromJson(Map<String, dynamic> json) =>
    BillingDetails(
      addressLine1: json['address_line1'] as String,
      addressLine2: json['address_line2'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$BillingDetailsToJson(BillingDetails instance) =>
    <String, dynamic>{
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'city': instance.city,
      'province': instance.province,
      'country': instance.country,
      'pin': instance.pin,
    };

ShippingDetails _$ShippingDetailsFromJson(Map<String, dynamic> json) =>
    ShippingDetails(
      shippingName: json['shipping_name'] as String,
      shippingEmail: json['shipping_email'] as String,
      shippingCode: json['shipping_code'] as String,
      shippingMobile: json['shipping_mobile'] as String,
      addressLine1: json['address_line1'] as String,
      addressLine2: json['address_line2'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      pin: json['pin'] as String,
      locationPin: json['location_pin'] as String,
      shippingCurrency: json['shipping_currency'] as String,
      shippingAmount: json['shipping_amount'] as String,
    );

Map<String, dynamic> _$ShippingDetailsToJson(ShippingDetails instance) =>
    <String, dynamic>{
      'shipping_name': instance.shippingName,
      'shipping_email': instance.shippingEmail,
      'shipping_code': instance.shippingCode,
      'shipping_mobile': instance.shippingMobile,
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'city': instance.city,
      'province': instance.province,
      'country': instance.country,
      'pin': instance.pin,
      'location_pin': instance.locationPin,
      'shipping_currency': instance.shippingCurrency,
      'shipping_amount': instance.shippingAmount,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      success: json['success'] as String,
      cancel: json['cancel'] as String,
      failure: json['failure'] as String,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'success': instance.success,
      'cancel': instance.cancel,
      'failure': instance.failure,
    };
