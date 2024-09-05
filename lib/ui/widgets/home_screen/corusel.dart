import 'package:asyltas/ui/common/app_colors.dart';
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
    'assets/images/slide1.webp',
    'assets/images/slide2.webp',
    'assets/images/slide3.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      i,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: i == 'assets/images/slide1.webp'
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Алмазный хрусталь',
                                style: TextStyle(
                                  color: newWhite,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 2),
                              Text(
                                '8мм',
                                style: TextStyle(
                                  color: newWhite,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : const Text(
                            'Стразы пришивные капля',
                            style: TextStyle(
                              color: newWhite,
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
