import 'package:flutter/material.dart';

class LogoLabelWidget extends StatelessWidget {
  const LogoLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'LT',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'LIFESPARK',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ],
    );
  }
}
