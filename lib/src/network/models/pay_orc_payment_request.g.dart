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
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      className: json['class'] as String,
      action: json['action'] as String,
      captureMethod: json['captureMethod'] as String,
      paymentToken: json['paymentToken'] as String,
      orderDetails:
          OrderDetails.fromJson(json['orderDetails'] as Map<String, dynamic>),
      customerDetails: CustomerDetails.fromJson(
          json['customerDetails'] as Map<String, dynamic>),
      billingDetails: BillingDetails.fromJson(
          json['billingDetails'] as Map<String, dynamic>),
      shippingDetails: ShippingDetails.fromJson(
          json['shippingDetails'] as Map<String, dynamic>),
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'class': instance.className,
      'action': instance.action,
      'captureMethod': instance.captureMethod,
      'paymentToken': instance.paymentToken,
      'orderDetails': instance.orderDetails,
      'customerDetails': instance.customerDetails,
      'billingDetails': instance.billingDetails,
      'shippingDetails': instance.shippingDetails,
      'urls': instance.urls,
    };

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
      mOrderId: json['mOrderId'] as String,
      amount: json['amount'] as String,
      convenienceFee: json['convenienceFee'] as String,
      quantity: json['quantity'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      'mOrderId': instance.mOrderId,
      'amount': instance.amount,
      'convenienceFee': instance.convenienceFee,
      'quantity': instance.quantity,
      'currency': instance.currency,
      'description': instance.description,
    };

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) =>
    CustomerDetails(
      mCustomerId: json['mCustomerId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'mCustomerId': instance.mCustomerId,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'code': instance.code,
    };

BillingDetails _$BillingDetailsFromJson(Map<String, dynamic> json) =>
    BillingDetails(
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$BillingDetailsToJson(BillingDetails instance) =>
    <String, dynamic>{
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'province': instance.province,
      'country': instance.country,
      'pin': instance.pin,
    };

ShippingDetails _$ShippingDetailsFromJson(Map<String, dynamic> json) =>
    ShippingDetails(
      shippingName: json['shippingName'] as String,
      shippingEmail: json['shippingEmail'] as String,
      shippingCode: json['shippingCode'] as String,
      shippingMobile: json['shippingMobile'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      pin: json['pin'] as String,
      locationPin: json['locationPin'] as String,
      shippingCurrency: json['shippingCurrency'] as String,
      shippingAmount: json['shippingAmount'] as String,
    );

Map<String, dynamic> _$ShippingDetailsToJson(ShippingDetails instance) =>
    <String, dynamic>{
      'shippingName': instance.shippingName,
      'shippingEmail': instance.shippingEmail,
      'shippingCode': instance.shippingCode,
      'shippingMobile': instance.shippingMobile,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'province': instance.province,
      'country': instance.country,
      'pin': instance.pin,
      'locationPin': instance.locationPin,
      'shippingCurrency': instance.shippingCurrency,
      'shippingAmount': instance.shippingAmount,
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
