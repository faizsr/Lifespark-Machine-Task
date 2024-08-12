import 'package:flutter/material.dart';

abstract class RemoteDataSource {
  Future<void> sentOtp(String number, BuildContext context);
  Future<String> verifyOtp(String verificationId, String userOtp);
  Future<void> logout();
}
