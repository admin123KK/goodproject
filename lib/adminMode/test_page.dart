import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/database.dart';

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
  }

  // Function to load items from the database
  void _loadItems() {
    databaseMethods.getItems().listen((snapshot) {
      setState(() {
        items = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    });
  }

  void updateGreeting() {
    DateTime now = DateTime.now();
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
              isLoading ? _buildShimmerLoader() : _buildPopularItemsList(),
              isLoading ? _buildShimmerLoader() : _itemsList(),
            ],
          ),
        ),
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
                    } else {}
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 255,
                            width: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
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
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                offset: Offset(0, 2),
                                blurRadius: 20)
                          ],
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.network(
                            item['image'] ??
                                'https://via.placeholder.com/90x110',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        item['name'] ?? 'Unnamed Item',
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
            margin: EdgeInsets.symmetric(vertical: 5),
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

class CustomSearch extends SearchDelegate {
  List<String> allData = [''];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
