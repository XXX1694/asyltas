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
      backgroundColor: newWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      viewModel.goToMainPage();
                    },
                    child: const Text(
                      'ASYLTAS',
                      style: TextStyle(
                        color: newBlack,
                        fontSize: 17,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      viewModel.goBack();
                    },
                    child: SvgPicture.asset(
                      'assets/сlose.svg',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: category.length,
                      itemBuilder: (context, index) => Align(
                        alignment: Alignment.center,
                        child: CupertinoButton(
                          padding: EdgeInsets.only(
                            bottom: index == category.length - 1 ? 40 : 20,
                            top: index == 0 ? 40 : 0,
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
                              color: newBlack,
                              fontSize: 18,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
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
