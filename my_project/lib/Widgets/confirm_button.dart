import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String label;
  final VoidCallback press;
  const ConfirmButton({required this.label, required this.press, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * .45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: TextButton(
        onPressed: press,
        child: Text(label),
      ),
    );
  }
}
