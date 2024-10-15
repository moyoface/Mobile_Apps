// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/register.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 231, 238, 133)),
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Montserrat',
                )),
        routes: {'/register': (context) => Register()},
        home: Navigation(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  GlobalKey? historyListKey;
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = WelcomePage();
        break;
      case 1:
        page = LoginPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    final mainArea = ColoredBox(
      color: colorScheme.onPrimary,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Expanded(child: mainArea),
            SafeArea(
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.login),
                    label: 'Login',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            )
          ],
        );
      }),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: Colors.black,
    );
    return Column(
      children: [
        StartLogo(context: context),
        SizedBox(
          height: 50,
        ),
        Center(
            child: Text(
          'Help For Tutors',
          style: style,
          textAlign: TextAlign.center,
        )),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'Помічник у організації занять',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )),
        SizedBox(height: 40),
        StartInfo(),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/register');
            },
            child: Text('Реєстрація'),
          ),
        )
      ],
    );
  }
}

class StartLogo extends StatelessWidget {
  const StartLogo({
    required this.context,
    super.key,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(30, 30),
              bottomRight: Radius.elliptical(30, 30))),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

class StartInfo extends StatelessWidget {
  const StartInfo({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          'Тут вперше?',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        SizedBox(height: 40),
        InputSyle('Username', 'Введіть username', context),
        SizedBox(height: 10),
        InputSyle('Password ', 'Введіть password', context),
        SizedBox(height: 30),
        ConfirmButton('Log in', context),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Не маєте акаунту ? ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: 'Створіть акаунт ! ',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushNamed('/register');
                  }),
          ]),
        )
      ],
    );
  }
}

Widget ConfirmButton(String title, BuildContext context) {
  return Container(
    height: 50,
    width: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Theme.of(context).colorScheme.primaryContainer,
    ),
    child: TextButton(
      onPressed: () {
        print('Success');
      },
      child: Text(title),
    ),
  );
}

Widget InputSyle(String title, String hintext, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 10),
    child: Row(
      children: [
        Text(
          '$title : ',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintext,
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
