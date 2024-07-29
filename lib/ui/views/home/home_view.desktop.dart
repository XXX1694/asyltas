import 'package:asyltas/ui/widgets/home_screen/mini_catalog.dart';
import 'package:asyltas/ui/widgets/home_screen/top_bar.dart';
import 'package:asyltas/ui/widgets/home_screen/top_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 70),
                TopBar(),
                SizedBox(height: 100),
                TopText(),
                SizedBox(height: 50),
                MiniCatalog(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
