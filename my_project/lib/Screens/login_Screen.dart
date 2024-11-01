import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/Provider/provider.dart';
import 'package:my_project/SQLite/database_helper.dart';
import 'package:my_project/Screens/profile.dart';
import 'package:my_project/Widgets/confirm_button.dart';
import 'package:my_project/Widgets/text_field_style.dart';
import 'package:my_project/Widgets/validations.dart';
import 'package:my_project/Widgets/welcome_logo.dart';
import 'package:provider/provider.dart';

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

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
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
          child: Consumer<UIProvider>(
            builder: (context, UIProvider notifier, child) {
              return ListTile(
                horizontalTitleGap: 2,
                title: const Text(
                  'Запам\'ятати мене',
                  style: TextStyle(fontSize: 14),
                ),
                leading: Checkbox(
                  activeColor: Theme.of(context).colorScheme.primaryContainer,
                  value: notifier.isChecked,
                  onChanged: (value) => notifier.toggleCheck(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Consumer<UIProvider>(
          builder: (context, UIProvider notifier, child) {
            return ConfirmButton(
              label: 'Увійти',
              press: () async {
                if (!await isConnected()) {
                  _showNoConnectionDialog();
                  return;
                }

                Users? usrDetails = await db.getUser(usrName.text);
                final res = await db.authenticate(
                    Users(usrName: usrName.text, usrPassword: password.text));
                if (notifier.isChecked == true) {
                  notifier.setRememberMe(usrName.text);
                }
                if (res == true) {
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(profile: usrDetails)),
                  );
                } else {
                  setState(() {
                    isLoginTrue = true;
                  });
                }
              },
            );
          },
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
                text: 'Створіть його ! ',
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
            'Username чи Пароль неправильні. Спробуйте ще раз',
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

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Відсутнє підключення'),
        content: Text('Для входу в систему потрібно з’єднання з інтернетом.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }
}
