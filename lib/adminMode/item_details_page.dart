import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/functions/esea_page.dart';
import 'package:goodproject/items/cart.dart';

class ItemDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final String description;

  const ItemDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _quantity = 1;
  // double Item_Price = 0;
  String userName = "";
  double _currentRating = 0;
  String deliveryLocation = "";

  void initState() {
    super.initState();
    fetchUserName();
    fetchItemRating();
    fetchLocation();
  }

  Future<void> fetchItemRating() async {
    //rating fetch garcha//
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('name', isEqualTo: widget.name)
          .get();
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _currentRating = snapshot.docs[0]['rating'] ?? 0.0;
        });
      }
    } catch (e) {
      print('error on fetching: $e');
    }
  }

  Future<void> updateItemRating(String itemName, double newRating) async {
    //storing the rating to the items store
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('name', isEqualTo: itemName)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs[0].reference;
        await docRef.update({'rating': newRating});
      } else {
        print('itemss not found');
      }
    } catch (e) {
      print('Error updating rating: $e');
    }
  }

//calculation of the totalCalculated amount
  double _calculateTotalAmount() {
    double totalAmount = _quantity * widget.price;
    if (_quantity >= 10) {
      totalAmount -= 30;
    }
    return totalAmount;
  }

  void incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  //working with the location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled.'),
        ),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied.'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied.'),
        ),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            content: Text(
              'Current location Shared: $address',
              style: const TextStyle(color: Color(0xFF91AD13)),
            ),
          ),
        );

        // Save the location to Firestore if needed
        await FirebaseFirestore.instance.collection('locations').add({
          'address': address,
          'email': FirebaseAuth.instance.currentUser?.email,
        });
      }
    } catch (e) {
      print('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: $e'),
        ),
      );
    }
  }

  Future<void> addToCart() async {
    String currentAddress = await getCurrentAddress();
    try {
      FirebaseFirestore.instance.collection('cart').add({
        'itemName': widget.name,
        'quantity': _quantity,
        'totalCost': _calculateTotalAmount(),
        'dateTime': DateTime.now(),
        'Email': FirebaseAuth.instance.currentUser?.email,
        'Name': FirebaseAuth.instance.currentUser?.displayName,
        'location': currentAddress
      });
      print('added to cart sucessfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          backgroundColor: Colors.black,
          content: const Center(
            child: Text(
              'Successfully  added to cart !!',
              style: TextStyle(color: Color(0xFF91AD13)),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Error add item $e');
    }
  }

  Future<void> fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("UserInfo")
            .doc(user.uid)
            .get();

        setState(() {
          userName = userDoc['Name'];
        });
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  void cashOrder() async {
    try {
      // Simulate payment completion (replace with actual logic)
      bool paymentCompleted = await simulatePaymentCompletion();

      if (paymentCompleted) {
        String currentAddress = await getCurrentAddress();
        // Payment completed successfully, store order in Firestore
        await FirebaseFirestore.instance.collection('cashOrder').add({
          'orderType': 'cash',
          'itemName': widget.name,
          'quantity': _quantity,
          'totalCost': _calculateTotalAmount(),
          'dateTime': DateTime.now(),
          'Email': FirebaseAuth.instance.currentUser?.email,
          'Name': FirebaseAuth.instance.currentUser?.displayName,
          'seen': false,
          'location': currentAddress
          // Other fields specific to cash orders
        });

        print('Order successfully placed (cash)');
        // Show success message or handle UI updates
      } else {
        // Payment not completed, handle accordingly (optional)
        print('Payment not completed for cash order');
        // Show error message or handle UI updates
      }
    } catch (e) {
      print('Error placing order (cash): $e');
    }
  }

// Function to handle online order
  void onlineOrder() async {
    try {
      // Simulate payment completion (replace with actual logic)
      bool paymentCompleted = await simulatePaymentCompletion();

      if (paymentCompleted) {
        String currentAddress = await getCurrentAddress();
        // Payment completed successfully, store order in Firestore
        await FirebaseFirestore.instance.collection('onlineOrder').add({
          'orderType': 'esewa',
          'itemName': widget.name,
          'quantity': _quantity,
          'totalCost': _calculateTotalAmount(),
          'dateTime': DateTime.now(),
          'Email': FirebaseAuth.instance.currentUser?.email,
          'Name': FirebaseAuth.instance.currentUser?.displayName,
          'seen': false,
          'location': currentAddress
          // Other fields specific to online orders
        });

        print('Order successfully placed (online)');
        // Show success message or handle UI updates
      } else {
        // Payment not completed, handle accordingly (optional)
        print('Payment not completed for online order');
        // Show error message or handle UI updates
      }
    } catch (e) {
      print('Error placing order (online): $e');
    }
  }

  void rawOrder() async {
    try {
      // Simulate payment completion (replace with actual logic)
      bool paymentCompleted = await simulatePaymentCompletion();

      if (paymentCompleted) {
        String currentAddress = await getCurrentAddress();
        // Payment completed successfully, store order in Firestore
        await FirebaseFirestore.instance.collection('rawOrder').add({
          'orderType': 'esewa',
          'itemName': widget.name,
          'quantity': _quantity,
          'totalCost': _calculateTotalAmount(),
          'dateTime': DateTime.now(),
          'Email': FirebaseAuth.instance.currentUser?.email,
          'Name': FirebaseAuth.instance.currentUser?.displayName,
          'seen': false,
          'location': currentAddress
          // Other fields specific to online orders
        });

        print('Order successfully placed (online)');
        // Show success message or handle UI updates
      } else {
        // Payment not completed, handle accordingly (optional)
        print('Payment not completed for online order');
        // Show error message or handle UI updates
      }
    } catch (e) {
      print('Error placing order (online): $e');
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

// Simulate payment completion function (replace with actual logic)
  Future<bool> simulatePaymentCompletion() async {
    // Simulate delay for payment completion
    await Future.delayed(Duration(seconds: 2));
    // Simulate success (return true) or failure (return false)
    return true; // Change to false to simulate failed payment
  }

//triggerNotification function used
  triggerNotifications() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'Khaja_App',
        title: 'Khaja Ghar',
        body: 'Your Order SelRoti is placed in the  Khaja Ghar',
        backgroundColor: const Color(0xFF91AD13),
      ),
    );
  }

  Future<void> clearNotification() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String currentAddress = "";
    if (placemark.isNotEmpty) {
      Placemark place = placemark[0];
      currentAddress = '${place.street},${place.locality}';
    }
    FirebaseFirestore.instance.collection('notification').add({
      'itemName': widget.name,
      'quantity': _quantity,
      'price': widget.price,
      'totalCost': _calculateTotalAmount(),
      'dateTime': DateTime.now(),
      'Email': FirebaseAuth.instance.currentUser?.email,
      "Name": FirebaseAuth.instance.currentUser?.displayName,
      'seen': false,
      'location': currentAddress,
      'cashPay': true
    });
  }

  Future<void> fetchLocation() async {
    try {
      // Query the collection to find the document with the desired field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notification')
          .where('location',
              isNotEqualTo: null) // Adjust this condition as needed
          .limit(1) // Assuming you want only the first document that matches
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        var data = snapshot.data() as Map<String, dynamic>;
        print('Fetched data: $data'); // Debugging line

        setState(() {
          deliveryLocation = data['location'] ?? 'Location not available';
          print('Delivery location set: $deliveryLocation'); // Debugging line
        });
      } else {
        setState(() {
          deliveryLocation = 'Document does not exist';
          print('Document does not exist'); // Debugging line
        });
      }
    } catch (e) {
      print('Error fetching location: $e'); // Debugging line
      setState(() {
        deliveryLocation = 'Error fetching location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            height: 340,
            width: 450,
          ),
          Container(
            height: 340,
            width: 470,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 27, 19, 19),
                Colors.transparent,
                Color.fromARGB(255, 13, 11, 11)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 33, horizontal: 9),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF91AD13),
                                ),
                              );
                            });
                        Timer(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        });
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout,
                        size: 27,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 23),
                  child: SizedBox(
                    height: 220,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          AppLocalizations.of(context).translate(widget.name),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mooli',
                              fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                RatingBar.builder(
                                  initialRating: _currentRating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _currentRating = rating;
                                    });
                                    updateItemRating(widget.name, rating);
                                  },
                                ),
                                // const SizedBox(
                                //   height: 4,
                                // ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('StarRatings'),
                                  style: const TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('Rs'),
                                      style: const TextStyle(
                                          fontSize: 27,
                                          fontFamily: 'Mooli',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 2, 99, 6)),
                                    ),
                                    Text(
                                      widget.price.toStringAsFixed(0),
                                      style: const TextStyle(
                                          fontFamily: 'Mooli',
                                          color: Color.fromARGB(255, 2, 99, 6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )
                                  ],
                                ),
                                Text(
                                    // 'Price: ${widget.price.toStringAsFixed(2)}',
                                    AppLocalizations.of(context)
                                        .translate('/perPiece'))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 33,
                        ),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('Descriptions'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate(widget.description),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context).translate('customize'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                          AppLocalizations.of(context).translate('noPiece')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: decrementQuantity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 33,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF91AD13)),
                            child: const Text(
                              '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 33,
                        width: 44,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF91AD13), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF91AD13))),
                              hintText: _quantity.toString(),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5)),
                        ),
                      ),
                      InkWell(
                        onTap: incrementQuantity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 33,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF91AD13)),
                            child: const Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 48,
                      ),
                      InkWell(
                        onTap: _getCurrentLocation,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      Text(AppLocalizations.of(context)
                          .translate('ShareLocation')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('total_costs')
                            .replaceAll(
                                '{cost}', _calculateTotalAmount().toString()),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 90,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: InkWell(
                        onTap: () {
                          addToCart();
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF91AD13),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context).translate('cart'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                InkWell(
                  onTap: () async {
                    rawOrder();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF91AD13),
                          ),
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Payement Status ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  fontFamily: 'Mooli'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate(
                                        'total_amount',
                                      )
                                      .replaceAll('{amount}',
                                          _calculateTotalAmount().toString()),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 28, 139, 31),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('ShareLocation'),
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocalizations.of(context)
                                    .translate('payWith')),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Esewa esewa = Esewa(
                                          context: context,
                                        );
                                        await esewa.pay();
                                        Navigator.pop(context);
                                      },
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/esewa.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/khalti.png',
                                          height: 65,
                                          width: 65,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(AppLocalizations.of(context)
                                    .translate('or')),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  cashOrder();
                                  clearNotification();
                                  Navigator.pop(context);
                                  Timer(Duration(seconds: 3), () {
                                    return triggerNotifications();
                                  });
                                  // triggerNotifications();
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('confirmCash'),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 28, 139, 31),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('cancel'),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                  child: Container(
                    height: 36,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF91AD13),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('OrderNow'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

// Function to handle cash order

//