// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_project/Screens/register_Screen.dart';
import 'package:my_project/Widgets/navigation.dart';
import 'package:my_project/Widgets/welcome_logo.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomePageState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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

class WelcomePageState extends ChangeNotifier {
  GlobalKey? historyListKey;
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
