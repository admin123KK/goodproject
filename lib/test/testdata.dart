import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataAnalysisPage extends StatefulWidget {
  @override
  _DataAnalysisPageState createState() => _DataAnalysisPageState();
}

class _DataAnalysisPageState extends State<DataAnalysisPage> {
  List<ItemOrder> _data = [];
  bool _isLoading = true;
  List<ItemOrder> _predictedData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('adminData').get();
    Map<String, int> itemCount = {};

    snapshot.docs.forEach((doc) {
      var item = doc['itemName'];
      var quantity = (doc['quantity'] as num?)?.toInt() ??
          0; // Cast quantity to int and handle null
      if (itemCount.containsKey(item)) {
        itemCount[item] = (itemCount[item] ?? 0) + quantity;
      } else {
        itemCount[item] = quantity;
      }
    });

    setState(() {
      _data = itemCount.entries.map((e) => ItemOrder(e.key, e.value)).toList();
      _isLoading = false;
      _predictedData = _predictFutureOrders(_data);
    });
  }

  List<ItemOrder> _predictFutureOrders(List<ItemOrder> data) {
    // Example: Simple prediction using average values
    double totalQuantity = 0;
    data.forEach((item) {
      totalQuantity += item.quantity;
    });

    double averageQuantity = totalQuantity / data.length;

    // Predict future orders as 20% more than average for each item
    List<ItemOrder> predictedData = [];
    data.forEach((item) {
      int predictedQuantity = (item.quantity * 1.2).toInt(); // Increase by 20%
      predictedData.add(ItemOrder(item.item, predictedQuantity));
    });

    return predictedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF91AD13),
        title: const Text(
          'KhajaGhar Analysis',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: const Text(
                      'Items Ordered',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      // title: const ChartTitle(text: 'Item vs Quantity'),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        // Historical data series
                        ColumnSeries<ItemOrder, String>(
                          dataSource: _data,
                          xValueMapper: (ItemOrder data, _) => data.item,
                          yValueMapper: (ItemOrder data, _) => data.quantity,
                          name: 'Historical',
                        ),
                        // Predicted data series
                        LineSeries<ItemOrder, String>(
                          dataSource: _predictedData,
                          xValueMapper: (ItemOrder data, _) => data.item,
                          yValueMapper: (ItemOrder data, _) => data.quantity,
                          name: 'Predicted',
                          markerSettings: const MarkerSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ItemOrder {
  final String item;
  final int quantity;

  ItemOrder(this.item, this.quantity);
}
