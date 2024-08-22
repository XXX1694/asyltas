import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/login_screen/email_field_mobile.dart';
import 'package:asyltas/ui/widgets/login_screen/password_field_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFormMobile extends StatefulWidget {
  const LoginFormMobile({
    super.key,
    required this.toRegistration,
    required this.toMainPage,
  });
  final Function toRegistration;
  final Function toMainPage;
  @override
  State<LoginFormMobile> createState() => _LoginFormMobileState();
}

class _LoginFormMobileState extends State<LoginFormMobile> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        const Text(
          'Войти',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: kcPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        EmailFieldMobile(
          controller: emailController,
        ),
        const SizedBox(height: 20),
        PasswordFieldMobile(
          controller: passwordController,
        ),
        const Spacer(),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () async {
            final res = await signInAndSaveToken(
              emailController.text,
              passwordController.text,
            );
            if (res) {
              widget.toMainPage();
            } else {
              // show error
            }
          },
          child: Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 35,
                  color: Colors.black12,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Войти',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            widget.toRegistration();
          },
          child: Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kcPrimaryColor, width: 1),
            ),
            child: const Center(
              child: Text(
                'Регистрация',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: kcPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
