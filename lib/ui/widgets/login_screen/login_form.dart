import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/login_screen/email_field.dart';
import 'package:asyltas/ui/widgets/login_screen/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.toRegistration,
    required this.toMainPage,
  });
  final Function toRegistration;
  final Function toMainPage;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      constraints: const BoxConstraints(
        maxWidth: 630,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Войти в ',
                  style: GoogleFonts.volkhov(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: 'Asyltas',
                  style: GoogleFonts.volkhov(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          EmailField(
            controller: emailController,
          ),
          const SizedBox(height: 20),
          PasswordField(
            controller: passwordController,
          ),
          const SizedBox(height: 35),
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
              height: 60,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 20),
                    blurRadius: 35,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Войти',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
              height: 60,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kcPrimaryColor, width: 1),
              ),
              child: Center(
                child: Text(
                  'Регистрация',
                  style: GoogleFonts.poppins(
                    color: kcPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
