# PayOrc Flutter

A Flutter plugin for orc payment.

## Developed By : PayOrc

## Getting Started

About SDK

Steps to follow:

## Step 1 : In your app, specify the environment during initialization.

    void main() {        
        PayOrcFlutter.initialize(
            merchantKey: 'your-merchant-key', // updated you merchantKey.
            merchantSecret: 'your-merchant-secret', // updated your merchantSecret.
            environment: Environment.test, // Switch to Environment.production for live
        );
        runApp(const MyApp());
    }

## Step 2 : Implement createPaymentWithWidget on widget will auto push on view.

    **To call this method on app:**

    await PayOrcFlutter.instance.createPaymentWithWidget(
        context: context,
        request: createPayOrcPaymentRequest(),
        onPopResult: (String? pOrderId) async {
            await _fetchTransaction(pOrderId);
        },
        errorResult: (message) {
            // display alert for the users
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
            currency: "AED", // should be dynamic currency
            description: "",
          ),
          customerDetails: CustomerDetails(
            mCustomerId: "123",
            name: "John Doe",
            email: "johndoe@example.com",
            mobile: "987654321",
            code: "971", // should not include + before code
          ),
          billingDetails: BillingDetails(
            addressLine1: "Po Box 12322",
            addressLine2: "Jebel Ali Free Zone",
            city: "Dubai",
            province: "Dubai", // state
            country: "AE", // 2-digit country code
            pin: "54044",
        ),
        shippingDetails: ShippingDetails(
            shippingName: "John Doe",
            shippingEmail: "email@company.com",
            shippingCode: "971", // No plus sign before code
            shippingMobile: "987654321",
            addressLine1: "Po Box 12322",
            addressLine2: "Jebel Ali Free Zone",
            city: "Dubai",
            province: "Dubai", // state
            country: "AE", // 2-digit country code
            pin: "54044",
            locationPin: "{URL}", // Placeholder URL
            shippingCurrency: "AED", // Dynamic currency
            shippingAmount: "0",
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

    final transaction = await PayOrcFlutter.instance.fetchPaymentTransaction(
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

      PayOrcFlutter.instance.clearData();
    }

## Step 5 : To clear local data call following method.

    **To call this method on app:**
    
    PayOrcFlutter.instance.clearData();

## Step 6 : Important

    **Update the version in pubspec.yaml file and also put the same in this constant variable
    PAY_ORC_SDK_VERSION (payorc_flutter/src/helper/constants.dart)**
