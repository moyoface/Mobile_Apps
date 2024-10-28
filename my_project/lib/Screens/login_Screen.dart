import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/SQLite/database_helper.dart';
import 'package:my_project/Screens/profile.dart';
import 'package:my_project/Widgets/confirm_button.dart';
import 'package:my_project/Widgets/text_field_style.dart';
import 'package:my_project/Widgets/validations.dart';
import 'package:my_project/Widgets/welcome_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    final res = await db
        .authenticate(Users(usrName: usrName.text, usrPassword: password.text));
    if (res == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(profile: usrDetails)),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: SafeArea(child: content())),
    );
  }

  Widget content() {
    return Column(
      children: [
        StartLogo(context: context),
        const SizedBox(height: 40),
        TextFieldStyle(
          hint: 'Username',
          icon: Icons.account_circle,
          controller: usrName,
          validator: Validations.validateUsername,
        ),
        TextFieldStyle(
          hint: 'Пароль',
          icon: Icons.lock,
          controller: password,
          passwordInvisible: true,
          validator: Validations.validatePassword,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListTile(
            horizontalTitleGap: 2,
            title: const Text(
              'Запам\'ятати мене',
              style: TextStyle(fontSize: 14),
            ),
            leading: Checkbox(
              activeColor: Theme.of(context).colorScheme.primaryContainer,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ConfirmButton(
          label: 'Увійти',
          press: login,
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Не маєте акаунту ? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Створіть акаунт ! ',
                style: const TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed('/register');
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (isLoginTrue)
          const Text(
            'Username чи Password неправильні. Спробуйте ще раз',
            style: TextStyle(
              color: Color.fromARGB(255, 245, 72, 72),
              fontSize: 10,
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
