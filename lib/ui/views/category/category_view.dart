import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'category_view.desktop.dart';
import 'category_view.tablet.dart';
import 'category_view.mobile.dart';
import 'category_viewmodel.dart';

class CategoryView extends StackedView<CategoryViewModel> {
  final String categoryId;
  final String categoryName;
  const CategoryView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget builder(
    BuildContext context,
    CategoryViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const CategoryViewMobile(),
      tablet: (_) => const CategoryViewTablet(),
      desktop: (_) => const CategoryViewDesktop(),
    );
  }

  @override
  CategoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryViewModel(
        categoryId: categoryId,
        categoryName: categoryName,
      );
}
