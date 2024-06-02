import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF91AD13),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Mooli'),
        ),
      ),
    );
  }
}
