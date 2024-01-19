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
  String greeting = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userEmail = user.email ?? "";
          userName = user.displayName ?? "";
          userPhoto = user.photoURL ?? "";
          updateGreeting();
        });
      }
    });
  }

  void updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  Widget foodItem({required String image, required String name}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                offset: Offset(0, 3),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(image), fit: BoxFit.contain),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontFamily: 'Mooli', fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget popularItem(
      {required String name, required String image, required String price}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 175,
        height: 255,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 60,
            ),
            ListTile(
              leading: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              trailing: Text(
                price,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star),
                Icon(Icons.star),
              ],
            ),
          ],
        ),
      ),
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
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting, $userName',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mooli',
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                          blurRadius: 10),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Container(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                                hintText: 'What  you like to have?',
                                border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      foodItem(
                          image:
                              'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                          name: 'All'),
                      foodItem(
                          image:
                              'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                          name: 'SelRoti'),
                      foodItem(
                          image:
                              'https://i.pinimg.com/736x/aa/c9/e3/aac9e3af4fa64b43527cd51df34ec567--nepali-food-roti.jpg',
                          name: "Fini"),
                      foodItem(
                          image:
                              'https://assets-cdn.kathmandupost.com/uploads/source/news/2020/lifestyle/batuk-1598575672.jpg',
                          name: 'Batuk'),
                      foodItem(
                          image:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Chukauni.jpg/1280px-Chukauni.jpg',
                          name: 'Chukaune'),
                      foodItem(
                          image: 'https://static.toiimg.com/photo/75146877.cms',
                          name: 'Momo'),
                      foodItem(
                          image:
                              'https://th.bing.com/th/id/OIP.Yr-FN0t1v6G4mbj50LkLjQAAAA?w=231&h=347&rs=1&pid=ImgDetMain',
                          name: 'Chuwamini'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Popular',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 400,
                  child: GridView.count(
                    shrinkWrap: false,
                    primary: false,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      popularItem(
                          name: 'SelRoti',
                          image:
                              'https://i.pinimg.com/originals/c5/43/fe/c543febbf4c3fc6e38f4abc4a1159f64.jpg',
                          price: 'Rs.200'),
                      popularItem(
                          name: 'Fini',
                          image:
                              'https://i.pinimg.com/736x/aa/c9/e3/aac9e3af4fa64b43527cd51df34ec567--nepali-food-roti.jpg',
                          price: 'Rs.300'),
                      popularItem(
                          name: 'Batuk',
                          image:
                              'https://assets-cdn.kathmandupost.com/uploads/source/news/2020/lifestyle/batuk-1598575672.jpg',
                          price: 'Rs.60'),
                      popularItem(
                          name: 'Chukaune',
                          image:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Chukauni.jpg/1280px-Chukauni.jpg',
                          price: 'Rs.50'),
                    ],
                  ),
                ),
              )
            ],
          ),
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
