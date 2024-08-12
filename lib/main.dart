import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/views/home_screen.dart';
import 'package:lifespark_machine_task/src/presentation/views/on_boarding_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Quicksand',
        ),
        debugShowCheckedModeBanner: false,
        title: 'Lifespark',
        home: FutureBuilder(
          future: di.getIt.get<GetLoginStatusUsecase>().call(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log('${snapshot.data}');
              return snapshot.data ?? false
                  ? const HomeScreen(loginStatus: true)
                  : const OnBoardingScreen();
            }
            log('Else case working');
            return const OnBoardingScreen();
          },
        ),
      ),
    );
  }
}
