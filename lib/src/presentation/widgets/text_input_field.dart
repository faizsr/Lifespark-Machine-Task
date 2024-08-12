import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;

  const TextInputField({
    super.key,
    this.validator,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(0.12),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
