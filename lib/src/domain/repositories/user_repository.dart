import 'package:flutter/material.dart';

abstract class UserRepository {
  Future<void> sentOtp(String number, BuildContext context);
  Future<String> verifyOtp(String verificationId, String userOtp);
  Future<void> createUser(String email, String name);
  Future<Map<String, dynamic>> getUserDetail();
  Future<void> saveLoginStatus(bool status);
  Future<bool> getLoginStatus();
  Future<void> logout();
}
