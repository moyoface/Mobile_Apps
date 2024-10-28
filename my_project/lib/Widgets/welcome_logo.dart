import 'package:flutter/material.dart';

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
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(30, 30),
              bottomRight: Radius.elliptical(30, 30))),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
