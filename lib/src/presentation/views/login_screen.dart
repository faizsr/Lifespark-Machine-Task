import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/presentation/providers/user_provider.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/custom_filled_button.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/logo_label_widget.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/phone_number_input_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool enableButton = false;
  String phnNumber = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogoLabelWidget(),
                const SizedBox(height: 40),
                const Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You will receive a 6 digit code \nto verify next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                PhoneNumberInputField(
                  onChanged: (value) {
                    enableButton = false;
                    if (value.number.isNotEmpty) {
                      enableButton = true;
                    }
                    phnNumber = value.completeNumber;
                    setState(() {});
                  },
                ),
                const Spacer(),
                CustomFilledButton(
                  onPressed: enableButton ? onLoginPressed : null,
                  text: 'Log In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onLoginPressed() async {
    if (formKey.currentState!.validate()) {
      Provider.of<UserProvider>(context, listen: false)
          .sentOtp(phnNumber, context);
    }
  }
}
