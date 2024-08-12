import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/config/alerts.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/data/data_sources/remote/remote_data_source.dart';
import 'package:lifespark_machine_task/src/presentation/views/otp_verification_screen.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> sentOtp(String number, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (phoneAuthCredential) {
          log('Verfication Completed: ${phoneAuthCredential.signInMethod}');
        },
        verificationFailed: (error) {
          log('Verification Failed: ${error.message} ${error.code}');
          final snackBar = CustomAlerts.snackBar(
              'Too many requests. Please try again later.');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (verificationId, forceResendingToken) {
          log('Verification Id: $verificationId, $forceResendingToken');
          nextScreen(
              context,
              OtpVerificationScreen(
                phoneNumber: number,
                verficationId: verificationId,
              ));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log('Verification Code Auto Retrieval: $verificationId');
        },
      );
    } on FirebaseAuthException catch (e) {
      log('Error senting otp: $e');
    }
  }

  @override
  Future<String> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      final result = await auth.signInWithCredential(credential);
      log('${result.additionalUserInfo!.isNewUser}');
      if (result.additionalUserInfo!.isNewUser) {
        log('New User');
        return 'new-user';
      } else {
        log('Verification Success');
        return 'success';
      }
    } on FirebaseAuthException catch (e) {
      log('Error verifying otp: $e');
      return 'failed';
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
