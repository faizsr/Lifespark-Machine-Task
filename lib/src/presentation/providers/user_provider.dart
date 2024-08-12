import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_user_detail_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/save_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/sent_otp_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/verify_otp_usecase.dart';

class UserProvider extends ChangeNotifier {
  final SentOtpUsecase sentOtpUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final SaveLoginStatusUsecase saveLoginStatusUsecase;
  final GetUserDetailUsecase getUserDetailUsecase;

  UserProvider({
    required this.sentOtpUsecase,
    required this.verifyOtpUsecase,
    required this.saveLoginStatusUsecase,
    required this.getUserDetailUsecase,
  });

  bool isLoading = false;
  String result = '';
  Map<String, dynamic> userData = {};

  Future<void> sentOtp(String number, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await sentOtpUsecase.call(number, context);
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }

  Future<String> verifyOtp(String verficationId, String userOtp) async {
    isLoading = true;
    notifyListeners();

    final response = await verifyOtpUsecase.call(verficationId, userOtp);
    result = response;
    notifyListeners();
    await saveLoginStatusUsecase.call(true);

    isLoading = false;
    notifyListeners();
    return response;
  }

  Future<void> getUserDetail(bool loginStatus) async {
    final data = await getUserDetailUsecase.call();
    userData = data;
    notifyListeners();
    if (loginStatus) {
      Fluttertoast.showToast(
        msg: "logged in as ${userData['email']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black54,
        fontSize: 14.0,
      );
    }
  }
}
