import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goodproject/database.dart';

class CreateNew extends StatefulWidget {
  @override
  _CreateNewState createState() => _CreateNewState();
}

class _CreateNewState extends State<CreateNew> {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController(); // Added
  final TextEditingController _imageController = TextEditingController();
  String _selectedItemId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Contrl'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseMethods.getItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!.docs;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text('Price: ${item['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _nameController.text = item['name'];
                        _priceController.text = item['price'].toString();
                        _descriptionController.text =
                            item['description']; // Added
                        _imageController.text = item['image'];
                        _selectedItemId = item.id;
                        _showEditItemDialog();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        databaseMethods.deleteItem(item.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _nameController.clear();
          _priceController.clear();
          _descriptionController.clear(); // Added
          _imageController.clear();
          _selectedItemId = "";
          _showEditItemDialog();
        },
      ),
    );
  }

  void _showEditItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_selectedItemId.isEmpty ? 'Add Item' : 'Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController, // Added
              decoration: InputDecoration(labelText: 'Description'), // Added
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(_selectedItemId.isEmpty ? 'Add' : 'Update'),
            onPressed: () {
              final itemData = {
                'name': _nameController.text,
                'price': double.parse(_priceController.text),
                'description': _descriptionController.text, // Added
                'image': _imageController.text,
              };
              if (_selectedItemId.isEmpty) {
                databaseMethods.addItem(
                    itemData, DateTime.now().millisecondsSinceEpoch.toString());
              } else {
                databaseMethods.updateItem(
                  _selectedItemId,
                  itemData,
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
