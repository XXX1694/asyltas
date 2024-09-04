import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  List<String> images = [
    'assets/images/ad1.png',
    'assets/images/ad2.png',
    'assets/images/ad3.png',
    'assets/images/ad4.png',
    'assets/images/ad5.png',
    'assets/images/ad6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  i,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
