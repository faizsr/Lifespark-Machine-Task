import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/config/strings.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_user_detail_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/save_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/views/login_screen.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/logo_label_widget.dart';
import 'package:lifespark_machine_task/injection_container.dart' as di;
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.loginStatus = false,
  });

  final bool loginStatus;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final saveLoginStatusUsecase = di.getIt.get<SaveLoginStatusUsecase>();
  Map<String, dynamic> user = {};

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  Future<void> getUserDetail() async {
    final getUserUsecase = di.getIt.get<GetUserDetailUsecase>();
    final data = await getUserUsecase.call();
    user = data;
    setState(() {});
    log('Data: $data ${widget.loginStatus}');
    if (widget.loginStatus) showToast();
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "logged in as ${user['email']}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black54,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoLabelWidget(),
                  MaterialButton(
                    minWidth: 20,
                    elevation: 0,
                    color: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      await saveLoginStatusUsecase.call(false);
                      nextScreenRemoveUntil(context, const LoginScreen());
                    },
                    child: const Text('Logout'),
                  )
                ],
              ),
              const Spacer(),
              LottieBuilder.asset(spaceLottie2),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome ${user['name']}!!',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
