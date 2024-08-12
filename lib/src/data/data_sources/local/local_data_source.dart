abstract class LocalDataSource {
  Future<void> createUser(String email, String name);
  Future<Map<String, dynamic>> getUserDetail();

  Future<void> saveLoginStatus(bool status);
  Future<bool> getLoginStatus();
}
