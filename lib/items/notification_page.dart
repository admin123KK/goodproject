import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/database.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final DatabaseMethods databaseMethods = DatabaseMethods();

    if (user == null) {
      return const Center(child: Text("User not logged in"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
        ),
        backgroundColor: const Color(0xFF91AD13),
        centerTitle: true,
      ),
      body: FutureBuilder<Stream<QuerySnapshot>>(
        future: databaseMethods.getUserNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching notifications"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No notifications available"));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: snapshot.data!,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No notifications available"));
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              print("Number of documents: ${documents.length}");

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data() as Map<String, dynamic>;
                  final itemName = data['itemName'] ?? 'Unknown';
                  final quantity = data['quantity'] ?? 'Unknown';
                  print("Item Name: $itemName");

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: const Text(
                        'Order Received',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Your Ordered Item $itemName"
                          ' total x$quantity'
                          ' is placed on the KhajaGhar'),
                      leading: const Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.green,
                      ),
                      // trailing: const Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.green,
                      // ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
