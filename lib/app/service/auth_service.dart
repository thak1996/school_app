import 'dart:developer';
import 'package:school_app/app/data/data_result.dart';
import 'package:school_app/app/data/exceptions.dart';
import 'package:school_app/app/models/user_model.dart';
import 'package:school_app/app/utils/secure_storage.dart';
import 'package:uno/uno.dart';

class AuthService {
  final _secureStorageService = const SecureStorageService();
  final _uno = Uno();
  final _baseUrl = 'http://localhost:8080/api';

  Future<DataResult<AuthModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _uno.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
      );
      log(response.toString());
      log("Passou aqui no Login");

      if (response.status == 200) {
        final authData = response.data;
        final authModel = AuthModel.fromJson(authData);
        await _secureStorageService.write(
            key: "AUTH_TOKEN", value: authModel.token);
        await _secureStorageService.write(
            key: "CURRENT_USER", value: authModel.user.toJson().toString());
        return DataResult.success(authModel);
      }
      return DataResult.failure(const GeneralException());
    } catch (e) {
      log(e.toString());
      return DataResult.failure(AuthException(code: e.toString()));
    }
  }

  Future<DataResult<String>> sendRecoveryCode({required String email}) async {
    try {
      final response = await _uno.post(
        '$_baseUrl/forgot-password',
        data: {'email': email},
      );
      if (response.status == 200) {
        final resetCode = response.data['reset_code'];
        if (resetCode == null) {
          return DataResult.failure(const GeneralException());
        }
        return DataResult.success(resetCode.toString());
      }
      return DataResult.failure(const GeneralException());
    } catch (e) {
      return DataResult.failure(AuthException(code: e.toString()));
    }
  }

  Future<DataResult<void>> validateResetCode({required String code}) async {
    try {
      final response = await _uno.post(
        '$_baseUrl/validate-reset-code',
        data: {'code': code},
      );
      if (response.status == 200) {
        return DataResult.success(null);
      }
      return DataResult.failure(const GeneralException());
    } catch (e) {
      return DataResult.failure(AuthException(code: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _secureStorageService.delete(key: 'CURRENT_USER');
    await _uno.post('$_baseUrl/logout');
  }
}
