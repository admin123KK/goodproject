import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<HomePage> {
  String userEmail = "";
  String userName = "";
  String userPhoto = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userEmail = user.email ?? "";
          userName = user.displayName ?? "";
          userPhoto = user.photoURL ?? "";
        });
      }
    });
  }

  Widget foodItem({required String image, required String name}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg'),
                  fit: BoxFit.cover)),
        ),
      ],
    );
  }

  Future<void> _showLogOUtDialog(BuildContext, context) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: const Text(
              'Logout',
              style: TextStyle(fontFamily: 'Mooli'),
            ),
            content: const Text(
              'Are you sure you want to logout?',
              style: TextStyle(color: Colors.red, fontFamily: 'Mooli'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF91AD13),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    // await _auth.signOut();
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'Khaja Ghar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mooli',
          ),
        ),
        backgroundColor: Color(0xFF91AD13),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,  $userName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 700,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search Food',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    fillColor: Colors.grey[600],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                    foodItem(
                        image:
                            'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                        name: 'SelRoti'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(userPhoto),
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1613425293967-16ae72140466?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      fit: BoxFit.fill)),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text('Home'),
            ),
            const ListTile(
              leading: Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              title: Text('Location'),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text('Settings'),
            ),
            const ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: Text('Share'),
            ),
            const ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.black,
              ),
              title: Text('Feedback'),
            ),
            const ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: Text('Help'),
            ),
            const ListTile(
              leading: Icon(
                Icons.sports_cricket_rounded,
              ),
              title: Text('Score Card'),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _showLogOUtDialog(BuildContext, context);
              },
            )
          ],
        ),
      ),
    );
  }
}
