import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class LogoutUserUsecase {
  final UserRepository userRepository;

  LogoutUserUsecase({required this.userRepository});

  Future<void> call() async {
    await userRepository.logout();
  }
}
