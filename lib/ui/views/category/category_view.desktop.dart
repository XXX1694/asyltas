import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'category_viewmodel.dart';

class CategoryViewDesktop extends ViewModelWidget<CategoryViewModel> {
  const CategoryViewDesktop({super.key});

  @override
  Widget build(BuildContext context, CategoryViewModel viewModel) {
    return const Scaffold(backgroundColor: Color(0xFFFFFFFF), body: SizedBox());
  }
}
