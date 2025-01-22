# flutter_pay_orc

A Flutter plugin for orc payment.

## Developed By : PayOrc

## Getting Started

About SDK

Steps to follow:

## Step 1 : In your app, specify the environment during initialization.

    void main() {        
        FlutterPayOrc.initialize(
            merchantKey: 'your-merchant-key', // updated you merchantKey.
            merchantSecret: 'your-merchant-secret', // updated your merchantSecret.
            environment: Environment.test, // Switch to Environment.production for live
        );
        runApp(const MyApp());
    }

## Step 2 : Implement createPaymentWithWidget on widget will auto push on view.

    **To call this method on app:**

    await FlutterPayOrc.instance.createPaymentWithWidget(
        context: context,
        request: createPayOrcPaymentRequest(),
        onPopResult: (String? pOrderId) async {
          await _fetchTransaction(pOrderId);
        },
        errorResult: (message) {
          // display alert for the users
        },
        onLoadingResult: (bool success) {
          // manage loading with this bool value
        });

## Step 3 : payment request object reference.

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
            email: "johndoe@example.com",
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
            shippingName: "John Doe",
            shippingEmail: "",
            shippingCode: "91",
            shippingMobile: "9876543210",
            addressLine1: "address 1",
            addressLine2: "address 2",
            city: "Mumbai",
            province: "Maharashtra",
            country: "IN",
            pin: "482005",
            locationPin: "https://www.google.com/maps?q=24.227923067092433,80.07790793685352",
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

## Step 4 : To fetch payment transaction status use p_order_id from create payment response.

    **To call this method on app:**

    final transaction = await FlutterPayOrc.instance.fetchPaymentTransaction(
      orderId: pOrderId.toString(),
      onLoadingResult: (loading) {
          // manage loading with this bool value
      },
      errorResult: (message) {
          // display alert for the users
      },
    );
    if (transaction != null) {
      // update transaction information to merchant server

      FlutterPayOrc.instance.clearData();
    }

## Step 5 : To clear local data call following method.

    **To call this method on app:**
    
    FlutterPayOrc.instance.clearData();
