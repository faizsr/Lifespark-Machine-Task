import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class CreateUserUsecase {
  final UserRepository userRepository;

  CreateUserUsecase({required this.userRepository});

  Future<void> call(String email, String name) async {
    await userRepository.createUser(email, name);
  }
}
