
import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class SentOtpUsecase {
  final UserRepository userRepository;

  SentOtpUsecase({required this.userRepository});

  Future<void> call(String number, BuildContext context) async {
    await userRepository.sentOtp(number, context);
  }
}
