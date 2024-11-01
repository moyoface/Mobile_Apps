import 'package:flutter/material.dart';

class TextFieldStyle extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool passwordInvisible;
  const TextFieldStyle({
    required this.hint,
    required this.icon,
    required this.controller,
    super.key,
    this.passwordInvisible = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        width: size.width * .8,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          obscureText: passwordInvisible,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            icon: Icon(icon),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
