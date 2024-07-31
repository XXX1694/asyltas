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
      backgroundColor: Color(0xFFFAFAFA),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: 1280,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 70),
                TopBar(),
                SizedBox(height: 100),
                TopText(),
                SizedBox(height: 50),
                MiniCatalog(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
