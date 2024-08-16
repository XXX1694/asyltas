import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'payment_viewmodel.dart';

class PaymentViewMobile extends ViewModelWidget<PaymentViewModel> {
  const PaymentViewMobile({super.key});

  @override
  Widget build(BuildContext context, PaymentViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logo_small.png'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                      padding: const EdgeInsets.only(right: 20),
                      onPressed: () {
                        viewModel.goToMenu();
                      },
                      child: SvgPicture.asset('assets/burger.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Оплата',
                    style: GoogleFonts.montserrat(
                      color: kcPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Оплатите полную сумму через каспи и отправьте чек на ватсап',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CupertinoButton(
                    color: const Color(0xFFF14635),
                    child: const Text('Kaspi'),
                    onPressed: () async {
                      const url = 'https://pay.kaspi.kz/pay/zgueos6v';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CupertinoButton(
                    color: const Color(0xFF47C756),
                    child: const Text('Whatsapp'),
                    onPressed: () async {
                      const url = 'https://wa.me/message/PQBV66LSNTE6O1';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
