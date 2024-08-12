import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lifespark_machine_task/src/data/data_sources/local/local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final userBox = Hive.box('users');
  final authBox = Hive.box('auth');
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> createUser(String email, String name) async {
    String number = auth.currentUser?.phoneNumber ?? '';
    log(number);
    final Map<String, dynamic> data = {
      'name': name,
      'number': number,
      'email': email,
    };
    log('Data: $number $email $name');
    await userBox.put(number, data);
    log('User Created $email');
  }

  @override
  Future<Map<String, dynamic>> getUserDetail() async {
    String number = auth.currentUser?.phoneNumber ?? '';
    final Map<dynamic, dynamic>? rawData = await userBox.get(number);
    return Map<String, dynamic>.from(rawData ?? {});
  }

  @override
  Future<bool> getLoginStatus() async {
    log('Getting');
    final value = await authBox.get('login');
    return value;
  }

  @override
  Future<void> saveLoginStatus(bool status) async {
    await authBox.put('login', status);
  }
}
