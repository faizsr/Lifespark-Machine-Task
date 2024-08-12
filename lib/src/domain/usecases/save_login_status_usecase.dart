import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class SaveLoginStatusUsecase {
  final UserRepository userRepository;

  SaveLoginStatusUsecase({required this.userRepository});

  Future<void> call(bool status) async {
    await userRepository.saveLoginStatus(status);
  }
}
