import 'package:asyltas/auth/auth_services.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/widgets/login_screen/email_field.dart';
import 'package:asyltas/ui/widgets/login_screen/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

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
    return SizedBox(
      width: 630,
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
          const SizedBox(height: 70),
          EmailField(
            controller: emailController,
          ),
          const SizedBox(height: 20),
          PasswordField(
            controller: passwordController,
          ),
          const SizedBox(height: 45),
          GestureDetector(
            onTap: () {
              signInAndSaveToken(emailController.text, passwordController.text);
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
          GestureDetector(
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
