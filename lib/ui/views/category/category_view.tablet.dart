import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'category_viewmodel.dart';

class CategoryViewTablet extends ViewModelWidget<CategoryViewModel> {
  const CategoryViewTablet({super.key});

  @override
  Widget build(BuildContext context, CategoryViewModel viewModel) {
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
