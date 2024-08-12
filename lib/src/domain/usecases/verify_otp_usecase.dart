import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class VerifyOtpUsecase {
  final UserRepository userRepository;

  VerifyOtpUsecase({required this.userRepository});

  Future<String> call(String verificationId, String userOtp) async {
    return await userRepository.verifyOtp(verificationId, userOtp);
  }
}
