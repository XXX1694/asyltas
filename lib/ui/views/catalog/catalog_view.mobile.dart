import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'catalog_viewmodel.dart';

class CatalogViewMobile extends ViewModelWidget<CatalogViewmodel> {
  const CatalogViewMobile({super.key});

  @override
  Widget build(BuildContext context, CatalogViewmodel viewModel) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(),
        ),
      ),
    );
  }
}
