import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'catalog_viewmodel.dart';

class CatalogViewMobile extends ViewModelWidget<CatalogViewmodel> {
  const CatalogViewMobile({super.key});

  @override
  Widget build(BuildContext context, CatalogViewmodel viewModel) {
    List<Map<String, String>> category = [
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
        'id': '0004',
        'name': 'Хрустал 4мм биконус',
      },
      {
        'id': '0005',
        'name': 'Хрустал 2мм',
      },
      {
        'id': '0006',
        'name': 'Хрустал 0.8мм',
      },
      {
        'id': '0007',
        'name': 'Хрустал алмаз 4мм',
      },
      {
        'id': '0008',
        'name': 'Хрустал капля 8/12мм',
      },
      {
        'id': '0009',
        'name': 'Хрустал 6/8мм',
      },
      {
        'id': '0010',
        'name': 'Поджемчук',
      },
      {
        'id': '0011',
        'name': 'Шашбау',
      },
      {
        'id': '0012',
        'name': 'Основа',
      },
      {
        'id': '0013',
        'name': 'Страз лента',
      },
      {
        'id': '0014',
        'name': 'Страз на листь',
      },
      {
        'id': '0015',
        'name': 'Перья',
      },
      {
        'id': '0016',
        'name': 'Расходной материал',
      },
      {
        'id': '0017',
        'name': 'Стразы капля 6х10',
      },
      {
        'id': '0018',
        'name': 'Стразы капля 8х13',
      },
      {
        'id': '0019',
        'name': 'Стразы капля 10х14',
      },
      {
        'id': '0020',
        'name': 'Стразы капля 13х18',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo_small.png'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                      padding: const EdgeInsets.only(right: 20),
                      onPressed: () {
                        viewModel.goToMenu();
                      },
                      child: SvgPicture.asset('assets/burger.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Каталог',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kcPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: category.length,
                        itemBuilder: (context, index) => Align(
                          alignment: Alignment.centerLeft,
                          child: CupertinoButton(
                            padding: EdgeInsets.only(
                              bottom: index == category.length - 1 ? 40 : 20,
                              top: index == 0 ? 20 : 0,
                            ),
                            onPressed: () {
                              viewModel.goToCategoryPage(
                                category[index]['id'].toString(),
                                category[index]['name'].toString(),
                              );
                            },
                            child: Text(
                              category[index]['name'].toString(),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
