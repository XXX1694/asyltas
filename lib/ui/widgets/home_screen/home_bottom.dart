import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Text(
              'Северное кольцо 23, Алатау 4 блок',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.41,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: SvgPicture.asset(
                'assets/inst.svg',
                height: 20,
                width: 20,
              ),
              onPressed: () async {
                const url =
                    'https://www.instagram.com/furnitura_asyl_tas?igsh=MXFyeWN6bjYwc3FyOQ%3D%3D&utm_source=qr ';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: SvgPicture.asset(
                'assets/whats.svg',
                height: 20,
                width: 20,
              ),
              onPressed: () async {
                const url = 'https://wa.me/message/PQBV66LSNTE6O1';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
