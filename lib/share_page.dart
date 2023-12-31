import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
class SharePage extends StatelessWidget {
  final String imageUrl =
      'https://images.unsplash.com/photo-1682687218147-9806132dc697?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  final String imageText = 'Sample Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text(
              imageText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  onPressed: () => _onDownloadPressed(context, imageUrl),
                ),
                SizedBox(width: 16.0),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  onPressed: () => _onSharePressed(context, imageUrl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
void _onDownloadPressed(BuildContext context, String imageUrl) async {
  try {
    var response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;

    var result = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
    
    if (result != null && result.isNotEmpty) {
      print('Image saved: $result');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image downloaded successfully'),
        ),
      );
    } else {
      print('Error saving image');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading image'),
        ),
      );
    }
  } catch (e) {
    print('Error saving image: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error downloading image'),
      ),
    );
  }
}
  void _onSharePressed(BuildContext context, String imageUrl) {
    Share.share('Check out this image: $imageUrl');
  }
}