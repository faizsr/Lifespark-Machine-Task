import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        log('Fronted: ${value.isLoading}');
        return MaterialButton(
          elevation: 0,
          minWidth: MediaQuery.of(context).size.width,
          height: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledColor: Colors.deepPurple.shade200,
          color: Colors.deepPurple,
          onPressed: onPressed,
          child: value.isLoading
              ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        );
      },
    );
  }
}
