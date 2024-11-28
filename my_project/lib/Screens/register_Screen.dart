import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/JSON/users.dart';
import 'package:my_project/SQLite/database_helper.dart';
import 'package:my_project/Screens/login_Screen.dart';
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

  bool isRegisterTrue = false;
  dynamic signup() async {
    var result = await db.getUserByUsername(usrName.text);
    if (result != usrName.text) {
      var res = await db.createUser(Users(
          name: name.text,
          email: email.text,
          usrName: usrName.text,
          usrPassword: password.text));
      if (res > 0) {
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } else {
      setState(() {
        isRegisterTrue = true;
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
    Size size = MediaQuery.of(context).size;
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
            validator: Validations.validateUsername,
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
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Будь ласка, повторіть пароль';
              }
              if (value != password.text) {
                return 'Паролі не збігаються';
              }
              return null;
            },
            passwordInvisible: true,
          ),
          const SizedBox(height: 40),
          Container(
            height: 50,
            width: size.width * .45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar;
                  signup();
                }
              },
              child: const Text('Зареєстуватися'),
            ),
          ),
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
          SizedBox(height: 10),
          if (isRegisterTrue)
            const Text(
              'Даний username вже використовується. Придумайте інший!',
              style: TextStyle(
                color: Color.fromARGB(255, 245, 72, 72),
                fontSize: 10,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
