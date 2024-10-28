import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/SQLite/database_helper.dart';
import 'package:my_project/Screens/login_Screen.dart';
import 'package:my_project/Widgets/confirm_button.dart';
import 'package:my_project/Widgets/text_Field_Style.dart';
import 'package:my_project/Widgets/validations.dart';
import 'package:my_project/Widgets/welcome_logo.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final usrName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final db = DatabaseHelper();
  dynamic signup() async {
    var res = await db.createUser(Users(
        name: name.text,
        email: email.text,
        usrName: usrName.text,
        usrPassword: password.text));
    if (res > 0) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: SafeArea(child: content())),
    );
  }

  Widget content() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          StartLogo(context: context),
          const SizedBox(height: 50),
          TextFieldStyle(
            hint: 'Ваше ім\'я',
            icon: Icons.person,
            controller: name,
            validator: Validations.validateName,
          ),
          TextFieldStyle(
            hint: 'Email',
            icon: Icons.email,
            controller: email,
            validator: Validations.validateEmail,
          ),
          TextFieldStyle(
            hint: 'Username',
            icon: Icons.account_circle,
            controller: usrName,
            validator: validateUsername,
          ),
          TextFieldStyle(
            hint: 'Пароль',
            icon: Icons.lock,
            controller: password,
            validator: Validations.validatePassword,
            passwordInvisible: true,
          ),
          TextFieldStyle(
            hint: 'Повторіть пароль',
            icon: Icons.lock,
            controller: confirmPassword,
            validator: Validations.validatePassword,
            passwordInvisible: true,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
              child: const Text('Перевірити дані')),
          SizedBox(height: 20),
          ConfirmButton(label: 'Sign Up', press: signup),
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
            ),
          ),
        ],
      ),
    );
  }

  String? validateUsername(String? value) {
    print('Succes');
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }

    // Username regex pattern (alphanumeric and underscores, 3-16 characters)
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username must be 3-16 characters long and contain only letters, numbers, and underscores';
    }

    return null;
  }
}
