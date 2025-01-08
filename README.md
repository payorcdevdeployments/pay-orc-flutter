# flutter_pay_orc

A Flutter plugin for orc payment.

## Developed By : Jere Pious

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

The plugin project was generated without specifying the `--platforms` flag, no platforms are currently supported.
To add platforms, run `flutter create -t plugin --platforms <platforms> .` in this directory.
You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/to/pubspec-plugin-platforms.

Steps to follow:

## Step 1 : In your app, specify the environment during initialization.

    void main() {        
        FlutterPayOrc.initialize(
            clientId: 'your-client-id', // updated you client id.
            merchantId: 'your-merchant-id', // updated your merchant id.
            environment: Environment.development, // Switch to Environment.production for live.
        );    
        runApp(const MyApp());
    }

## Step 2 : To start the payment use step 2 or step 3 on app Scaffold for the payment webview and call back will return the needful information.


    Widget startPayment({
        required BuildContext context,
        required double amount,
        required String currency,
        required Function(bool success, String? transactionId) onPaymentResult,
        }) {
            final paymentUrl = instance.configMemoryHolder.paymentUrl;
            return PayOrcWebView(
            paymentUrl: paymentUrl!,
            onPaymentResult: onPaymentResult,
        );
    }

## Step 3 : To start the payment use step 2 or step 3 on app Scaffold for the payment webview and call back will return the needful information.

    PayOrcWebView(
        paymentUrl: FlutterPayOrc.instance.configMemoryHolder.paymentUrl!,
        onPaymentResult: (success, transactionId) {
            if (success) {
                print('Payment successful. Transaction ID: $transactionId');
            } else {
                print('Payment failed.');
            }
        },
    );

## Step 4 : payment request object.

    final requestData = PayOrcPaymentRequest(
            data: Data(
                className: "ECOM",
                action: "SALE",
                captureMethod: "MANUAL",
                paymentToken: "",
                orderDetails: OrderDetails(
                mOrderId: "1234",
                amount: "100",
                convenienceFee: "0",
                quantity: "2",
                currency: "AED",
                description: "",
            ),
            customerDetails: CustomerDetails(
                mCustomerId: "123",
                name: "John Doe",
                email: "pawan@payorc.com",
                mobile: "987654321",
                code: "971",
            ),
            billingDetails: BillingDetails(
                addressLine1: "address 1",
                addressLine2: "address 2",
                city: "Amarpur",
                province: "Bihar",
                country: "IN",
                pin: "482008",
            ),
            shippingDetails: ShippingDetails(
                shippingName: "Pawan Kushwaha",
                shippingEmail: "",
                shippingCode: "91",
                shippingMobile: "9876543210",
                addressLine1: "address 1",
                addressLine2: "address 2",
                city: "Jabalpur",
                province: "Madhya Pradesh",
                country: "IN",
                pin: "482005",
                locationPin: "https://location/somepoint",
                shippingCurrency: "AED",
                shippingAmount: "10",
            ),
            urls: Urls(
                success: "",
                cancel: "",
                failure: "",
            ),
        ),
    );