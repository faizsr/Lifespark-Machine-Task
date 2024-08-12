import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifespark_machine_task/src/data/data_sources/local/local_data_source.dart';
import 'package:lifespark_machine_task/src/data/data_sources/local/local_data_source_impl.dart';
import 'package:lifespark_machine_task/src/data/data_sources/remote/remote_data_source.dart';
import 'package:lifespark_machine_task/src/data/data_sources/remote/remote_data_source_impl.dart';
import 'package:lifespark_machine_task/src/data/repositories/user_repostory_impl.dart';
import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';
import 'package:lifespark_machine_task/src/domain/usecases/create_user_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/get_user_detail_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/logout_user_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/save_login_status_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/sent_otp_usecase.dart';
import 'package:lifespark_machine_task/src/domain/usecases/verify_otp_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/providers/user_provider.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('users');
  await Hive.openBox('auth');

  // ------ Providers ------
  getIt.registerFactory<UserProvider>(
    () => UserProvider(
      sentOtpUsecase: getIt.call(),
      verifyOtpUsecase: getIt.call(),
      saveLoginStatusUsecase: getIt.call(),
      getUserDetailUsecase: getIt.call(),
    ),
  );

  // ------ Use Cases ------
  getIt.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<GetUserDetailUsecase>(
    () => GetUserDetailUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<SentOtpUsecase>(
    () => SentOtpUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<SaveLoginStatusUsecase>(
    () => SaveLoginStatusUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<GetLoginStatusUsecase>(
    () => GetLoginStatusUsecase(userRepository: getIt.call()),
  );
  getIt.registerLazySingleton<LogoutUserUsecase>(
    () => LogoutUserUsecase(userRepository: getIt.call()),
  );

  // ------ Repository ------
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepostoryImpl(
        localDataSource: getIt.call(), remoteDataSource: getIt.call()),
  );

  // ------ Remote Data Source ------
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  // ------ Local Data Source ------
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );
}
