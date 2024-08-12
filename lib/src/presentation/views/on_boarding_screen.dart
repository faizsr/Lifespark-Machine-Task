import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/config/strings.dart';
import 'package:lifespark_machine_task/src/presentation/views/login_screen.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/custom_filled_button.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            children: [
              const Spacer(),
              Lottie.asset(spaceLottie1),
              const SizedBox(height: 20),
              const Text(
                'Welcome to \n$appName Tech',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                appAbout,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 40),
              CustomFilledButton(
                onPressed: () => nextScreen(context, const LoginScreen()),
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
