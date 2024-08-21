import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<AuthUserModel> login(
      {required String email, required String password});
  Future<void> logout({required String token});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<AuthUserModel> login(
      {required String email, required String password}) async {
    final response = await client.post(
      Uri.parse('${Urls.authBaseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return AuthUserModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout({required String token}) async {
    final response = await client.post(
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<AuthUserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final response =
        await client.post(Uri.parse('${Urls.authBaseUrl}/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'name': name,
              'email': email,
              'password': password,
            }));

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return AuthUserModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }
}
