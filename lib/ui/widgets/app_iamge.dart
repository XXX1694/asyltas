import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppImage extends StatefulWidget {
  final String imageUrl;

  const AppImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _AppImageState createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  late Future<Uint8List> _imageBytesFuture;

  @override
  void initState() {
    super.initState();
    _imageBytesFuture = _loadImage(widget.imageUrl);
  }

  Future<Uint8List> _loadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageBytesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading image');
        } else if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        } else {
          return const Text('No image available');
        }
      },
    );
  }
}
