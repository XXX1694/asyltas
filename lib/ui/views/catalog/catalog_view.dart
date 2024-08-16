import 'package:asyltas/ui/views/catalog/catalog_view.mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'catalog_view.desktop.dart';
import 'catalog_viewmodel.dart';

class CatalogView extends StackedView<CatalogViewmodel> {
  const CatalogView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CatalogViewmodel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const CatalogViewMobile(),
      tablet: (_) => const CatalogViewDesktop(),
      desktop: (_) => const CatalogViewDesktop(),
    );
  }

  @override
  CatalogViewmodel viewModelBuilder(
    BuildContext context,
  ) =>
      CatalogViewmodel();
}
