import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection('UserInfo').snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserNotifications() async {
    return await FirebaseFirestore.instance.collection('cashPay').snapshots();
  }

  Future<Stream<QuerySnapshot>> getClearNotifications() async {
    return await FirebaseFirestore.instance
        .collection('notification')
        .snapshots();
  }

  // Add methods for handling other collections
  Future<void> addItem(Map<String, dynamic> itemData, String id) async {
    return await FirebaseFirestore.instance
        .collection("items")
        .doc(id)
        .set(itemData);
  }

  Future<void> updateItem(String id, Map<String, dynamic> updatedData) async {
    return await FirebaseFirestore.instance
        .collection("items")
        .doc(id)
        .update(updatedData);
  }

  Future<void> deleteItem(String id) async {
    return await FirebaseFirestore.instance
        .collection("items")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot> getItems() {
    return FirebaseFirestore.instance.collection('items').snapshots();
  }
}
