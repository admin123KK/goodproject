import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
          onPaymentSuccess: (EsewaPaymentSuccessResult result) async {
            debugPrint('Sucess');
            storeOrderInFirestore();
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

void storeOrderInFirestore() async {
  try {
    // Get current address ligcha

    String currentAddress = await getCurrentAddress();

    // Store onlineOrder data in Firestore keto
    await FirebaseFirestore.instance.collection('onlineOrder').add({
      'orderType': 'online', // Example, adjust as per your logic
      'itemName': 'Widget', // Example item name, replace with actual data
      'quantity': 1, // Example quantity, replace with actual data
      'totalCost': 100.0, // Example total cost, replace with actual calculation
      'dateTime': DateTime.now(),
      'Email': FirebaseAuth.instance.currentUser?.email,
      'Name': FirebaseAuth.instance.currentUser?.displayName,
      'seen': false,
      'location': currentAddress,
    });

    print('Order successfully stored in Firestore.');
  } catch (e) {
    print('Error storing order in Firestore: $e');
  }
}

// Function to get current address (replace with actual geolocation logic)
Future<String> getCurrentAddress() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return '${place.street}, ${place.locality}, ${place.administrativeArea}';
    } else {
      return 'Unknown';
    }
  } catch (e) {
    print('Error getting current address: $e');
    return 'Unknown';
  }
}
