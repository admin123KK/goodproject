import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
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

  Future<Stream<QuerySnapshot>> getUser() async {
    return await FirebaseFirestore.instance.collection('cashPay').snapshots();
  }
}
