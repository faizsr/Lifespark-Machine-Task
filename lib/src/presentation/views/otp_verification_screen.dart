import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/config/alerts.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/domain/usecases/save_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/verify_otp_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/views/create_user_screen.dart';
import 'package:lifespark_machine_task/src/presentation/views/home_screen.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/custom_filled_button.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/logo_label_widget.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/otp_input_field.dart';
import 'package:lifespark_machine_task/injection_container.dart' as di;

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verficationId;
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verficationId,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  bool enableButton = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.back),
                ),
                const SizedBox(width: 10),
                const LogoLabelWidget(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verify Phone',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Code is sent to ${widget.phoneNumber}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              OtpInputField(
                controller: otpController,
                onChanged: (value) {
                  enableButton = value.length == 6 ? true : false;
                  setState(() {});
                },
              ),
              const Spacer(),
              CustomFilledButton(
                onPressed: enableButton ? onVerifyPressed : null,
                text: 'Verfiy',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onVerifyPressed() async {
    final verifyUserUsecase = di.getIt.get<VerifyOtpUsecase>();
    final saveLoginStatusUsecase = di.getIt.get<SaveLoginStatusUsecase>();

    final result =
        await verifyUserUsecase.call(widget.verficationId, otpController.text);

    if (result == 'success') {
      await saveLoginStatusUsecase.call(true);
      nextScreenRemoveUntil(context, const HomeScreen());
    } else if (result == 'new-user') {
      await saveLoginStatusUsecase.call(true);
      nextScreen(context, const CreateUserScreen());
    } else if (result == 'failed') {
      log('Verification Failed');
      final snackBar = CustomAlerts.snackBar('Invalid Otp');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
