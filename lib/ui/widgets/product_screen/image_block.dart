import 'package:asyltas/models/product.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBlock extends StatelessWidget {
  const ImageBlock({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 20),
        SizedBox(
          width: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: product.images!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                child: SizedBox(
                  height: 71,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        fit: BoxFit.cover,
                        image: FirebaseImageProvider(
                          FirebaseUrl(
                            product.images![index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                fit: BoxFit.cover,
                image: FirebaseImageProvider(
                  FirebaseUrl(
                    product.images![0],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
