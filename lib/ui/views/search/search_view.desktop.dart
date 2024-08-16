import 'package:asyltas/ui/widgets/registration_screen/registration_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchViewDesktop extends ViewModelWidget<SearchViewModel> {
  const SearchViewDesktop({super.key});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 124 * deviceHeight / 1325,
            horizontal: 140 * deviceWidth / 2200,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFDBDBDB),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(flex: 90),
                    Image.asset(
                      'assets/images/logo_small.png',
                      height: 70,
                    ),
                    const Spacer(flex: 200),
                    RegistrationForm(
                      toLogin: () {
                        viewModel.goToLoginPage();
                      },
                      toMainPage: () {
                        viewModel.goToMainPage();
                      },
                    ),
                    const Spacer(flex: 240),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          child: Text(
                            'Asyltas Terms & Codnitions',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 26),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
