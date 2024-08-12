import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/data/data_sources/local/local_data_source.dart';
import 'package:lifespark_machine_task/src/data/data_sources/remote/remote_data_source.dart';
import 'package:lifespark_machine_task/src/domain/repositories/user_repository.dart';

class UserRepostoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepostoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> createUser(String email, String name) async {
    await localDataSource.createUser(email, name);
  }

  @override
  Future<Map<String, dynamic>> getUserDetail() async {
    return await localDataSource.getUserDetail();
  }

  @override
  Future<void> sentOtp(String number, BuildContext context) async {
    await remoteDataSource.sentOtp(number, context);
  }

  @override
  Future<String> verifyOtp(String verificationId, String userOtp) async {
    return await remoteDataSource.verifyOtp(verificationId, userOtp);
  }

  @override
  Future<bool> getLoginStatus() async {
    return await localDataSource.getLoginStatus();
  }

  @override
  Future<void> saveLoginStatus(bool status) async {
    await localDataSource.saveLoginStatus(status);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
