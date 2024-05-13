import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/constant/esewa.dart';

class Esewa {
  pay() {
    try {
      EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
              clientId: kEsewaClientId,
              environment: Environment.test,
              secretId: kEsewaSecretKey),
          esewaPayment: EsewaPayment(
            productId: "1d71jd81",
            productName: "Sel Roti",
            productPrice: '60',
            callbackUrl:
                'https://esewa.com.np/mobile/transaction?txnRefId={refId} ',
          ),
          onPaymentSuccess: (EsewaPaymentSuccessResult result) {
            debugPrint('Sucess');
            verify(result);
          },
          onPaymentFailure: () {
            debugPrint('Failure Payment');
          },
          onPaymentCancellation: () {
            debugPrint('Payment Canceled');
          });
    } catch (e) {
      debugPrint('Exception');
    }
  }

  verify(EsewaPaymentSuccessResult result) {
    //To:After succes call this to verify the function
  }
}
