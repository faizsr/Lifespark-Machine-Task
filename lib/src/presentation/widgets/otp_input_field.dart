import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      onChanged: onChanged,
      defaultPinTheme: PinTheme(
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.12),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.zero,
        width: 55,
        height: 55,
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
