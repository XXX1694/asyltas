import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'catalog_viewmodel.dart';

class CatalogViewTablet extends ViewModelWidget<CatalogViewmodel> {
  const CatalogViewTablet({super.key});

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
