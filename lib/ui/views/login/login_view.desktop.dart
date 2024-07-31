import 'package:asyltas/ui/widgets/login_screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginViewDesktop extends ViewModelWidget<HomeViewModel> {
  const LoginViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(140),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFDBDBDB),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(30),
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
                    const LoginForm(),
                    const Spacer(flex: 240),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {},
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
