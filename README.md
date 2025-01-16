# flutter_pay_orc

A Flutter plugin for orc payment.

## Developed By : PayOrc

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

The plugin project was generated without specifying the `--platforms` flag, no platforms are
currently supported.
To add platforms, run `flutter create -t plugin --platforms <platforms> .` in this directory.
You can also find a detailed instruction on how to add platforms in the `pubspec.yaml`
at https://flutter.dev/to/pubspec-plugin-platforms.

Steps to follow:

## Step 1 : In your app, specify the environment during initialization.

    void main() {        
        FlutterPayOrc.initialize(
            environment: Environment.test, // Switch to Environment.live for production.
        );    
        runApp(const MyApp());
    }

## Step 2 : After init have to validate the merchant key and secret.

    **Method name on sdk:**

    Future<void> validateMerchantKeys(
      {required PayOrcKeysRequest request,
      required Function(String? message) successResult,
      required Function(String? message) errorResult}) async {
        try {
          final response = await _client.validateMerchantKeys(request);
          if (response.status == PayOrcStatus.success) {
            await instance.preferenceHelper
                .saveMerchantKey(request.merchantKey.toString());
            await instance.preferenceHelper
                .saveMerchantSecret(request.merchantSecret.toString());
            successResult.call(response.message);
          } else {
            errorResult.call(response.message);
          }
        } on HttpException catch (e) {
          errorResult.call(e.message);
        }
    }

    **Method name on app:**
        
    await FlutterPayOrc.instance.validateMerchantKeys(
        request: PayOrcKeysRequest(
            merchantKey: 'your-merchant-key', // updated you merchantKey.
            merchantSecret: 'your-merchant-secret', // updated your merchantSecret.
            env: FlutterPayOrc.instance.configMemoryHolder.envType
        ),
        successResult: (message) {
            on Success SDK will save the merchant key and secrent in preferance.
            we can show alert if need
        },
        errorResult: (message) {
            on Error we can show alert if need
        });

## Step 3 : Implement createPaymentWithWidget on widget will auto push on view.

    **Method name on sdk:**

        Future<void> createPaymentWithWidget(
              {required BuildContext context,
              required PayOrcPaymentRequest request,
              required Function(bool loading) onLoadingResult,
              required Function(String? message) errorResult,
              required Function(String? pOrderId) onPopResult}) async {
            try {
               final merchantKey = await instance.preferenceHelper.getMerchantKey();
               final merchantSecret =
               await instance.preferenceHelper.getMerchantSecret();
                
              if (merchantKey == null || merchantSecret == null) {
                errorResult.call("Merchant key / secret invalid");
                return;
              }
              onLoadingResult.call(true);
              final response = await _client.createPayment(request);
              configMemoryHolder.payOrcPaymentResponse = response;
              final paymentUrl =
                  instance.configMemoryHolder.payOrcPaymentResponse?.iframeLink;
              if (context.mounted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PayOrcWebView(
                          paymentUrl: paymentUrl!,
                          onPopResult: onPopResult,
                        )));
              }
            } on HttpException catch (e) {
              errorResult.call(e.message);
            } finally {
              onLoadingResult.call(false);
            }
        }

    **To call this method on app:**

    await FlutterPayOrc.instance.createPaymentWithWidget(
        context: context,
        request: createPayOrcPaymentRequest(),
        onPopResult: (String? pOrderId) async {
          await _fetchTransaction(pOrderId);
        },
        errorResult: (message) {
          debugPrint('errorResult $message');
        },
        onLoadingResult: (bool success) {
          setState(() {
            loading = success;
          });
        });

## Step 4 : payment request object reference.

    PayOrcPaymentRequest(
        data: Data(
          className: PayOrcClass.ecom.name.toUpperCase(),
          action: PayOrcAction.sale.name.toUpperCase(),
          captureMethod: PayOrcCaptureMethod.manual.name.toUpperCase(),
          paymentToken: "",
          orderDetails: OrderDetails(
            mOrderId: "1234",
            amount: "500",
            convenienceFee: "0",
            quantity: "1",
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
          parameters: [
            {
              "alpha": "",
            },
            {
              "beta": "",
            },
            {
              "gamma": "",
            },
            {
              "delta": "",
            },
            {
              "epsilon": "",
            }
          ],
          customData: [
            {
              "alpha": "",
            },
            {
              "beta": "",
            },
            {
              "gamma": "",
            },
            {
              "delta": "",
            },
            {
              "epsilon": "",
            }
          ],
        ),
    ); 

Note :

* All fields are mandatory
* When there is no data for a field you should send it as empty String not pass null
* Here the class, action and capture method are enums
* Here parameters and customData will be List of HashMap

## Step 5 : To fetch payment transaction status use p_order_id from create payment response.

    **Method name on sdk:**

    Future<PayOrcPaymentTransactionResponse?> fetchPaymentTransaction(
      {required String orderId,
      required Function(String? message) errorResult}) async {
        try {
          final merchantKey = await instance.preferenceHelper.getMerchantKey();
          final merchantSecret =
              await instance.preferenceHelper.getMerchantSecret();
    
          if (merchantKey == null || merchantSecret == null) {
            errorResult.call("Merchant key / secret invalid");
            return;
          }
          final response = await _client.fetchPaymentTransaction(orderId);
          configMemoryHolder.payOrcPaymentTransactionResponse = response;
          return response;
        } on HttpException catch (e) {
          errorResult.call(e.message);
          return null;
        }
    }

    **To call this method on app:**

    final transaction = await FlutterPayOrc.instance.fetchPaymentTransaction(
      orderId: pOrderId.toString(),
      errorResult: (message) {
        debugPrint('errorResult $message');
        _showErrorAlert(context, message);
      },
    );
    if (transaction != null) {
      debugPrint('transaction ${transaction.toJson()}');
      FlutterPayOrc.instance.clearData();
    }

## Step 6 : To clear data call following method.

    **Method name on sdk:**
    
    void clearData() {
        instance.configMemoryHolder = ConfigMemoryHolder();
    }
    
    **To call this method on app:**
    
    FlutterPayOrc.instance.clearData();
