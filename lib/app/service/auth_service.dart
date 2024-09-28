import 'package:school_app/app/data/data_result.dart';
import 'package:school_app/app/data/exceptions.dart';
import 'package:school_app/app/models/user_model.dart';
import 'package:school_app/app/utils/secure_storage.dart';
import 'package:uno/uno.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final _secureStorageService = const SecureStorageService();
  final _uno = Uno();
  final _baseUrl = dotenv.env['API_BASE_URL'];

  Future<DataResult<UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _uno.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
      );
      
      if (response.status == 200) {
        final userData = response.data;
        final user = UserModel(
          name: userData['name'],
          email: userData['email'],
          uid: userData['uid'],
        );
        await _secureStorageService.write(key: "CURRENT_USER", value: user.toJson());
        return DataResult.success(user);
      }
      return DataResult.failure(const GeneralException());
    } catch (e) {
      return DataResult.failure(AuthException(code: e.toString()));
    }
  }

  Future<DataResult<UserModel>> getUser() async {
    try {
      String? userJson = await _secureStorageService.read(key: "CURRENT_USER");
      if (userJson != null) {
        UserModel user = UserModel.fromJson(userJson);
        return DataResult.success(user);
      }
      return DataResult.failure(const UserException(code: 'user-not-found'));
    } catch (e) {
      return DataResult.failure(UserException(code: e.toString()));
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _uno.post(
      '$_baseUrl/register',
      data: {'email': email, 'password': password},
    );
  }

  Future<void> signOut() async {
    await _secureStorageService.delete(key: 'CURRENT_USER');
    await _uno.post('$_baseUrl/logout');
  }
}
