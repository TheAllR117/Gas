import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gasfast/global/environment.dart';
//import 'package:gasfast/src/models/balance/send_balance_responce.dart';
import 'package:gasfast/src/models/errors/error_response.dart';
import 'package:gasfast/src/models/errors/token_validation_response.dart';
import 'package:gasfast/src/models/login/login_response.dart';
import 'package:gasfast/src/models/register/register_response.dart';
import 'package:gasfast/src/models/user/user_main.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  factory AuthService() {
    return _instance;
  }

  // Create storage
  final _storage = new FlutterSecureStorage();

  LoginResponse? user;
  UserResponse? userMain;
  TokenValidationResponse? token;
  ErrorResponse? error;
  RegisterResponse? errorList;
  final _dio = new Dio();

  Future<bool> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final resp =
        await _dio.post('${Environment.apiUrl}/login', queryParameters: data);

    //print(resp.data);

    if (validateStatus(resp)) {
      if (resp.data['ok']) {
        final data = LoginResponse.fromJson(resp.data);
        await _saveToken(data.token!);
        this.user = data;
        return true;
      } else {
        final data = ErrorResponse.fromJson(resp.data);
        this.error = data;
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> register(
    String name,
    // ignore: non_constant_identifier_names
    String first_surname,
    // ignore: non_constant_identifier_names
    String second_surname,
    String email,
    String password,
    // ignore: non_constant_identifier_names
    String password_confirmation,
    String birthdate,
    String sex,
    String phone,
    String car,
  ) async {
    final data = {
      'name': name,
      'first_surname': first_surname,
      'second_surname': second_surname,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'birthdate': birthdate,
      'sex': sex,
      'phone': phone,
      'car': car
    };

    final resp = await _dio.post('${Environment.apiUrl}/client/store',
        queryParameters: data);

    print(resp.data);

    if (validateStatus(resp)) {
      if (resp.data['ok']) {
        final data = LoginResponse.fromJson(resp.data);
        await _saveToken(data.token!);
        this.user = data;
        return true;
      } else {
        final data = RegisterResponse.fromJson(resp.data);
        this.errorList = data;
        return false;
      }
    } else {
      return false;
    }
  }

  bool validateStatus(Response<dynamic> data) {
    print(data.statusCode);
    if (data.statusCode == 200) {
      return true;
    } else if (data.statusCode! >= 500) {
      return false;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    if (token == null) return false;
    _dio.options.headers["Authorization"] = "Bearer " + token;
    final resp = await _dio.get('${Environment.apiUrl}/client/show');
    if (!validateStatus(resp)) {
      return false;
    }

    if (resp.data['ok']) {
      this.userMain = UserResponse.fromJson(resp.data);
      return true;
    } else {
      this.token = TokenValidationResponse.fromJson(resp.data);
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
