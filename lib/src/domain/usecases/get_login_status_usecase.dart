import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class GetLoginStatusUsecase {
  final UserRepository userRepository;

  GetLoginStatusUsecase({required this.userRepository});

  Future<bool> call() async {
    return await userRepository.getLoginStatus();
  }
}
