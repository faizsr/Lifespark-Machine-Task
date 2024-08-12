import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/providers/user_provider.dart';
import 'package:lifespark_machine_task/src/presentation/views/home_screen.dart';
import 'package:lifespark_machine_task/src/presentation/views/on_boarding_screen.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final theme = ThemeData(
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Quicksand',
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => di.getIt<UserProvider>(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          title: 'Lifespark',
          home: FutureBuilder(
            future: di.getIt.get<GetLoginStatusUsecase>().call(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data ?? false
                    ? const HomeScreen(loginStatus: true)
                    : const OnBoardingScreen();
              }
              return const OnBoardingScreen();
            },
          ),
        ),
      ),
    );
  }
}
