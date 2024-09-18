import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/common/placeholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<Map<String, String>> category = [
  {
    'id': '0000',
    'name': 'Все',
  },
  {
    'id': '0001',
    'name': 'Хрустал 8мм',
  },
  {
    'id': '0002',
    'name': 'Хрустал 6мм',
  },
  {
    'id': '0003',
    'name': 'Хрустал 4мм',
  },
  {
    'id': '0005',
    'name': 'Хрустал 2мм',
  },
  {
    'id': '0007',
    'name': 'Хрустал алмаз 4мм',
  },
  {
    'id': '0017',
    'name': "Стразы капля 6х10",
  },
  {
    'id': '0018',
    'name': "Стразы капля 8х13",
  },
  {
    'id': '0019',
    'name': "Стразы капля 10х14",
  },
];

class CatalogPlacegolder extends StatelessWidget {
  const CatalogPlacegolder({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      children: category.map((item) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      color: Colors.grey.shade200,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Text(
                //   'Имя товара',
                //   style: TextStyle(
                //     fontFamily: 'Gilroy',
                //     color: newBlack,
                //     fontSize: 15,
                //     fontWeight: FontWeight.w600,
                //   ),
                //   textAlign: TextAlign.center,
                //   // overflow: TextOverflow.ellipsis,
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: ShrimerPlaceholder(
                    height: 17,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 4),
                // const Text(
                //   "999,00 ₸",
                //   style: TextStyle(
                //     fontFamily: 'Gilroy',
                //     color: newBlack,
                //     fontSize: 13,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: ShrimerPlaceholder(
                    height: 15,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 4),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondMain,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    height: 32,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'Подробнее',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: newWhite,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: newBlack,
                        width: 1,
                      ),
                    ),
                    height: 32,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'В корзину',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          color: newBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
