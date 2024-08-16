// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:asyltas/ui/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppImage extends StatefulWidget {
  final String imageUrl;

  const AppImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
          return const ShrimerPlaceholder(
            height: double.infinity,
            width: double.infinity,
          );
        } else if (snapshot.hasError) {
          return const ErrorPlaceholder(
            height: double.infinity,
            width: double.infinity,
          );
        } else if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const ErrorPlaceholder(
              height: double.infinity,
              width: double.infinity,
            ),
          );
        } else {
          return const ErrorPlaceholder(
            height: double.infinity,
            width: double.infinity,
          );
        }
      },
    );
  }
}
