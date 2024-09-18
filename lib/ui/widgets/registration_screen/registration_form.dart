import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/login_screen/email_field.dart';
import 'package:asyltas/ui/widgets/login_screen/password_field.dart';
import 'package:asyltas/ui/widgets/registration_screen/name_field.dart';
import 'package:asyltas/ui/widgets/registration_screen/password_field_copy.dart';
import 'package:asyltas/ui/widgets/registration_screen/phone_field.dart';
import 'package:asyltas/ui/widgets/registration_screen/surname_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    super.key,
    required this.toLogin,
    required this.toMainPage,
  });
  final Function toLogin;
  final Function toMainPage;
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      constraints: const BoxConstraints(
        maxWidth: 630,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Создать аккаунт',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 35),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: NameField(controller: nameController)),
                const SizedBox(width: 18),
                Expanded(child: SurnameField(controller: surnameController)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: EmailField(controller: emailController)),
                const SizedBox(width: 18),
                Expanded(child: PhoneField(controller: phoneController)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: PasswordField(controller: passwordController)),
                const SizedBox(width: 18),
                Expanded(
                    child: PasswordFieldCopy(
                        controller: cofirmPasswordController)),
              ],
            ),
          ),
          const SizedBox(height: 35),
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
              height: 60,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(10),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Уже есть аккаунт ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontSize: 16,
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
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
