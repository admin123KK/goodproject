import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelRotiPage extends StatefulWidget {
  const SelRotiPage({super.key});

  @override
  State<SelRotiPage> createState() => _SelRotiPageState();
}

class _SelRotiPageState extends State<SelRotiPage> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            'assets/images/selroti.png',
            fit: BoxFit.cover,
          ),
          Container(
            height: 400,
            width: 450,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 32, 24, 24),
                  Colors.transparent,
                  Color.fromARGB(255, 37, 28, 28)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 33),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 380),
            child: Container(
              // height: 180,
              // width: 450,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'SelRoti',
                      style: TextStyle(
                          fontFamily: 'Mooli',
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IgnorePointer(
                              ignoring: false,
                              child: RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.orange[600],
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                '  4 Star',
                                style: TextStyle(color: Colors.orange[600]),
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rs.60',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 9, 114, 12),
                                  // fontFamily: 'Mooli',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('/per piece')
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Text(
                      '''SelRoti is a traditional Nepalese delicacy,  deep-frie
bread made from rice flour batter mixed with sugar, 
milk, and a hint of cardamom. Often enjoyed during festivals and special occasions,SelRoti embodies the warmth of  Nepalese hospitality and the richness of  culinary  heritage.''',
                      maxLines: 6,
                      style: TextStyle(fontSize: 13.5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      'Customize you Order',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text('No of piece you want'),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: decrementQuantity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              alignment: Alignment.center,
                              height: 29,
                              width: 36,
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
                          height: 29,
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
                                hintText: quantity.toString(),
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
                              height: 29,
                              width: 36,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Order Status',
                                    style: TextStyle(fontFamily: 'Mooli'),
                                  ),
                                  content: const Text(
                                    'Your order has been placed sucefully',
                                    style: TextStyle(
                                      color: Color(0xFF91AD13),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(color: Colors.black),
                                        ))
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF91AD13),
                          ),
                          child: Center(child: Text('Order Now')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
