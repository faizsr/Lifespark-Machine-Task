import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/config/strings.dart';
import 'package:lifespark_machine_task/src/domain/usecases/save_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/providers/user_provider.dart';
import 'package:lifespark_machine_task/src/presentation/views/login_screen.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/logo_label_widget.dart';
import 'package:lifespark_machine_task/injection_container.dart' as di;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .getUserDetail(widget.loginStatus);
    super.initState();
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
                  logoutBtn(context),
                ],
              ),
              const Spacer(),
              LottieBuilder.asset(spaceLottie2),
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome ${value.userData['name']}!!',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton logoutBtn(BuildContext context) {
    return MaterialButton(
      minWidth: 20,
      elevation: 0,
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () async {
        await saveLoginStatusUsecase.call(false);
        nextScreenRemoveUntil(context, const LoginScreen());
      },
      child: const Text('Logout'),
    );
  }
}
