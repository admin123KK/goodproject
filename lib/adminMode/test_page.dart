import 'package:flutter/material.dart';
import 'package:goodproject/app_localization.dart';
import 'package:goodproject/database.dart';
import 'package:shimmer/shimmer.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khaja Ghar'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning Sir'),
            SizedBox(height: 20),
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
                        spreadRadius: 2,
                        blurRadius: 10)
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.search),
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
                          decoration: const InputDecoration(
                              hintText: "What do you like to ?"),
                          readOnly: true,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(AppLocalizations.of(context).translate('categories')),
            isLoading ? _buildShimmerLoader() : _buildPopularItemsList(),
            isLoading ? _buildShimmerLoader() : _itemsList(),
          ],
        ),
      ),
    );
  }

  Widget _itemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Popular',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ItemPage()));
                    // Navigate to detail page when an item is tapped
                    // Handle the case when required properties are null
                  }
                },
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
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
                                    item['name'] ?? 'Unnamed Item',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [Text(item['price'].toString())],
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
              );
            },
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
          height: 200,
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
                        height: 110,
                        width: 90,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                                blurRadius: 13)
                          ],
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
          child: Shimmer.fromColors(
            period: Duration(seconds: 5), // Set custom duration here
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 150,
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 5),
            ),
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
                    Shimmer.fromColors(
                      period: Duration(seconds: 2), // Set custom duration here
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 90,
                        height: 110,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                    SizedBox(height: 5),
                    Shimmer.fromColors(
                      period: Duration(seconds: 2), // Set custom duration here
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 16,
                        width: 70,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
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
