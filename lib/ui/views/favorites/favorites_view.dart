import 'package:asyltas/ui/views/favorites/favorites_view.mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import 'favorites_view.desktop.dart';
import 'favorites_viewmodel.dart';

class FavoritesView extends StackedView<FavoritesViewModel> {
  const FavoritesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    FavoritesViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const FavoritesViewMobile(),
      tablet: (_) => const FavoritesViewDesktop(),
      desktop: (_) => const FavoritesViewDesktop(),
    );
  }

  @override
  FavoritesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FavoritesViewModel();
}
