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
  final BuildContext context;

  Esewa({required this.context});

  pay() async {
    try {
      // Fetch the first document from the 'rawOrder' collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('rawOrder')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String itemName = documentSnapshot['itemName'];
        String totalCost = documentSnapshot['totalCost'].toString();
        int quantity = documentSnapshot['quantity'];

        // Initiate Esewa payment with fetched details
        EsewaFlutterSdk.initPayment(
          esewaConfig: EsewaConfig(
              clientId: kEsewaClientId,
              environment: Environment.test,
              secretId: kEsewaSecretKey),
          esewaPayment: EsewaPayment(
            productId: "1d71jd81",
            productName: itemName,
            productPrice: totalCost,
            callbackUrl:
                'https://esewa.com.np/mobile/transaction?txnRefId={refId} ',
          ),
          onPaymentSuccess: (EsewaPaymentSuccessResult result) async {
            debugPrint('Success');
            await storeOrderInFirestore(
                itemName, quantity, double.parse(totalCost));
            notificationClear(itemName, quantity, double.parse(totalCost));
            verify(result);
          },
          onPaymentFailure: () {
            debugPrint('Failure Payment');
          },
          onPaymentCancellation: () {
            debugPrint('Payment Canceled');
          },
        );
      } else {
        debugPrint('No items found in Firestore');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  verify(EsewaPaymentSuccessResult result) {
    // After success call this to verify the function
  }
}

Future<void> storeOrderInFirestore(
    String itemName, int itemQuantity, double totalCost) async {
  try {
    // Get current address
    String currentAddress = await getCurrentAddress();

    // Store onlineOrder data in Firestore
    await FirebaseFirestore.instance.collection('onlineOrder').add({
      'orderType': 'online',
      'itemName': itemName,
      'quantity': itemQuantity,
      'totalCost': totalCost,
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

Future<void> adminDataCollection(
    String itemName, int itemQuantity, double totalCost) async {
  try {
    // Get current address
    String currentAddress = await getCurrentAddress();

    // Store onlineOrder data in Firestore
    await FirebaseFirestore.instance.collection('adminData').add({
      'orderType': 'esewa',
      'itemName': itemName,
      'quantity': itemQuantity,
      'totalCost': totalCost,
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

Future<void> notificationClear(
    String itemName, int itemQuantity, double totalCost) async {
  try {
    // Get current address
    String currentAddress = await getCurrentAddress();

    // Store onlineOrder data in Firestore
    await FirebaseFirestore.instance.collection('notification').add({
      'orderType': 'online',
      'itemName': itemName,
      'quantity': itemQuantity,
      'totalCost': totalCost,
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
