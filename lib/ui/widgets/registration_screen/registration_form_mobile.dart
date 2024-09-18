import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/login_screen/email_field_mobile.dart';
import 'package:asyltas/ui/widgets/login_screen/password_field_mobile.dart';
import 'package:asyltas/ui/widgets/registration_screen/name_field_mobile.dart';
import 'package:asyltas/ui/widgets/registration_screen/password_field_copy_mobile.dart';
import 'package:asyltas/ui/widgets/registration_screen/phone_field_mobile.dart';
import 'package:asyltas/ui/widgets/registration_screen/surname_field_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationFormMobile extends StatefulWidget {
  const RegistrationFormMobile({
    super.key,
    required this.toLogin,
    required this.toMainPage,
  });
  final Function toLogin;
  final Function toMainPage;
  @override
  State<RegistrationFormMobile> createState() => _RegistrationFormMobileState();
}

class _RegistrationFormMobileState extends State<RegistrationFormMobile> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController cofirmPasswordController;

  @override
  void initState() {
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    cofirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    cofirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        const Text(
          'Создать аккаунт',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: kcPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        NameFieldMobile(controller: nameController),
        const SizedBox(height: 12),
        SurnameFieldMobile(controller: surnameController),
        const SizedBox(height: 12),
        EmailFieldMobile(controller: emailController),
        const SizedBox(height: 12),
        PhoneFieldMobile(controller: phoneController),
        const SizedBox(height: 12),
        PasswordFieldMobile(controller: passwordController),
        const SizedBox(height: 12),
        PasswordFieldCopyMobile(controller: cofirmPasswordController),
        const Spacer(),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () async {
            // final bool res = await registerUser(
            //   email: emailController.text,
            //   password: passwordController.text,
            //   name: nameController.text,
            //   surname: surnameController.text,
            //   phoneNumber: phoneController.text,
            // );
            // if (res) {
            //   widget.toMainPage();
            //   // go to main page
            // } else {
            //   // show error
            // }
          },
          child: Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.circular(2),
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
                'Создать аккаунт',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Уже есть аккаунт ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                widget.toLogin();
              },
              child: const Text(
                'Войти',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF4F6D9F),
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
