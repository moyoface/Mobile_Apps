import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  dynamic route() {
    Navigator.of(context).pushReplacementNamed('/start');
  }

  dynamic startTimer() {
    final duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 231, 238, 133),
      child: Container(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
