import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/myApp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        StartLogo(context: context),
        const SizedBox(height: 50),
        InputSyle('Username', 'Вигадайте username', context),
        const SizedBox(height: 20),
        InputSyle('Email', 'test@gmail.com', context),
        const SizedBox(height: 20),
        InputSyle('Password', 'Введіть пароль', context),
        const SizedBox(height: 20),
        InputSyle('Confirm password', 'Підтвердіть пароль', context),
        const SizedBox(height: 40),
        ConfirmButton('Sign up', context),
        const SizedBox(height: 10),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: 'Вже є акаунт ? ',
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pop();
                },
            ),
          ],
        )),
      ],
    );
  }
}
