import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goodproject/adminMode/admin_page.dart';
import 'package:goodproject/adminMode/shimmer.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/database.dart';
import 'package:goodproject/items/notification_page.dart';
import 'package:goodproject/my_orderpage.dart';
import 'package:goodproject/setting_page.dart';
import 'package:goodproject/test/riders_app.dart';
import 'package:goodproject/verifypages/location_page.dart';
import 'package:goodproject/verifypages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'item_details_page.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  String userName = "";
  String greeting = "";
  String userEmail = "";
  String userPhoto = "";
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _loadItems();
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
    FirebaseFirestore.instance
        .collection('notification')
        .where('seen', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        notificationCount = snapshot.docs.length;
      });
    });
  }

  void _markNotificationSeen() async {
    //notification seen unseen bhako cha ki chaina bhaneyra define
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('notification')
        .where('seen', isEqualTo: false)
        .get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.update({'seen': true});
    }
    setState(() {
      notificationCount = 0;
    });
  }

  // Function to load items from the database double working withe rating plus items load process
  void _loadItems() {
    databaseMethods.getItems().listen((snapshot) async {
      List<Map<String, dynamic>> tempItems = [];
      for (var doc in snapshot.docs) {
        var itemData = doc.data() as Map<String, dynamic>;
        // Fetch the rating for each item
        double rating = await _fetchItemRating(doc.id);
        itemData['rating'] = rating;
        tempItems.add(itemData);
      }
      tempItems.sort((a, b) => b['rating'].compareTo(a['rating']));
      setState(() {
        items = tempItems;
        isLoading = false;
      });
    });
  }

  Future<double> _fetchItemRating(String itemId) async {
    var ratingDoc =
        await FirebaseFirestore.instance.collection('items').doc(itemId).get();
    if (ratingDoc.exists &&
        ratingDoc.data() != null &&
        ratingDoc.data()!['rating'] != null) {
      return ratingDoc.data()!['rating'].toDouble();
    } else {
      return 0.0;
    }
  }

  void updateGreeting() {
    DateTime now = DateTime.now(); //working with the greeting
    int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greeting = (AppLocalizations.of(context).translate('GoodMorning'));
      });
    } else if (hour < 17) {
      setState(() {
        greeting = (AppLocalizations.of(context).translate('GoodAfternoon'));
      });
    } else {
      setState(() {
        greeting = (AppLocalizations.of(context).translate('GoodEvening'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFF91AD13),
                      ));
                    });
                Timer(const Duration(seconds: 1), () {
                  _markNotificationSeen();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                });
              },
              child: Container(
                  child: notificationCount > 0
                      ? Badge(
                          label: Text(notificationCount.toString()),
                          child: const Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.black,
                            size: 30,
                          ))
                      : const Icon(
                          Icons.notifications_active_outlined,
                          size: 30,
                          color: Colors.black,
                        )),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('khajaGhar'),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Mooli'),
        ),
        backgroundColor: const Color(0xFF91AD13),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting, $userName',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Mooli'),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 2),
                          spreadRadius: 2.5,
                          blurRadius: 10)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Expanded(
                          child: Container(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate('wyouLike'),
                                border: InputBorder.none),
                            onTap: () {
                              showSearch(
                                  context: context, delegate: CustomSearch());
                            },
                            readOnly: true,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).translate('categories'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              isLoading
                  ? Shimmer(child: _buildShimmerLoader())
                  : _buildPopularItemsList(),
              isLoading
                  ? Shimmer(
                      child: _buildPopularItemsList(),
                    )
                  : _itemsList(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.green,
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(userPhoto),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1613425293967-16ae72140466?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8M',
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.home,
                color: Colors.black,
                size: 27,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationPage()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 27,
              ),
              title: Text(
                'Location',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingPage()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
                size: 27,
              ),
              title: Text(
                'Setting',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OrderPage()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.dining_outlined,
                color: Colors.black,
                size: 27,
              ),
              title: Text(
                'My Order',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPage()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.black,
                size: 27,
              ),
              title: Text(
                'Feedback',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RidersApp()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.motorcycle,
                color: Colors.black,
                size: 27,
              ),
              title: Text(
                'Riders Mode',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showLogOUtDialog(BuildContext, context);
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
                size: 27,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _itemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Text(
            AppLocalizations.of(context).translate('Popular'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: 520,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    if (item['name'] != null &&
                        item['image'] != null &&
                        item['price'] != null &&
                        item['description'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailPage(
                            name: item['name'],
                            image: item['image'],
                            price: item['price'],
                            description: item['description'],
                          ),
                        ),
                      );
                      // Navigate to detail page when an item is tapped
                      // Handle the case when required properties are null
                    } else {
                      print('Something bad check it mate test');
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 250,
                            width: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 3,
                                    offset: Offset(0, 3),
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ClipOval(
                                    child: Image.network(
                                      item['image'],
                                      fit: BoxFit.cover,
                                      width: 130,
                                      height: 130,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            item['name'].toString() ?? ""),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                              'Rs',
                                            ),
                                            style: const TextStyle(
                                                // fontFamily: 'Mooli',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            item['price'].toStringAsFixed(0),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // fontFamily: 'Mooli',
                                                fontSize: 16,
                                                color: Colors.green),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                        itemCount: 5,
                                        itemSize: 27,
                                        initialRating: item['rating'] ?? 0,
                                        allowHalfRating: true,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                        onRatingUpdate: (rating) {
                                          setState(() {});
                                          print(rating);
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _storingRatingToFireStore(double rating) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('ratings').add({
      'rating': rating,
    });
  }

  // Widget to build the list of popular items
  Widget _buildPopularItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 165,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  if (item['name'] != null &&
                      item['image'] != null &&
                      item['price'] != null &&
                      item['description'] != null) {
                    // Navigate to detail page when an item is tapped

                    // Handle the case when required properties are null
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AppLocalizations.of(context).translate(item['name']),
                        style: const TextStyle(
                          fontFamily: 'Mooli',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget to build shimmer loader
  Widget _buildShimmerLoader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 20,
            width: 150,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 110,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),

                    const SizedBox(height: 5),
                    // Shimmer.fromColors(
                    //   period: Duration(seconds: 2), // Set custom duration here
                    //   baseColor: Colors.grey[300]!,
                    //   highlightColor: Colors.grey[100]!,
                    Container(
                      height: 16,
                      width: 70,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomSearch extends SearchDelegate<String> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: firestore.collection('items').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items found.'));
          }
          final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
          final List<Map<String, dynamic>> items = docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .where((item) => item['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title:
                    Text(AppLocalizations.of(context).translate(item['name'])),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDetailPage(
                              name: item['name'],
                              image: item['image'],
                              price: item['price'],
                              description: item['description'])));
                },
              );
            },
          );
        });
  }
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
          content: Text(
            AppLocalizations.of(context).translate('areYou'),
            style: const TextStyle(color: Colors.red, fontFamily: 'Mooli'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).translate('cancel'),
                style: const TextStyle(
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
