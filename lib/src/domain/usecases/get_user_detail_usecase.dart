import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class GetUserDetailUsecase {
  final UserRepository userRepository;

  GetUserDetailUsecase({required this.userRepository});

  Future<Map<String, dynamic>> call() async {
    return await userRepository.getUserDetail();
  }
}
