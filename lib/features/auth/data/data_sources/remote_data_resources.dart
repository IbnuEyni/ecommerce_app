import 'dart:convert';

import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/network/custom_client.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<String> login({required String email, required String password});
  Future<void> logout();
  Future<AuthUserModel> me({required String token});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> login(
      {required String email, required String password}) async {
    final response = await client.post(
      '${Urls.authBaseUrl}/login',
      {
        'email': email,
        'password': password,
      },
    );

    debugPrint("API response: ${response.body}");

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      debugPrint("\n\n\n\n\n\n\n\n JSON response: $jsonResponse");
      return jsonResponse['data']['access_token'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    final response = await client.post(
      '${Urls.authBaseUrl}/logout',
      {},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<AuthUserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      '${Urls.authBaseUrl}/register',
      {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    debugPrint("\n\n\n\n ${response.body}");

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      debugPrint("\n\n\n\nJSON response: $jsonResponse");
      return AuthUserModel.fromJson(jsonResponse['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthUserModel> me({required String token}) async {
    client.authToken = token;
    final response = await client.get(
      '${Urls.authBaseUrl}/users/me',
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return AuthUserModel.fromJson(jsonResponse['data']);
    } else {
      throw ServerException();
    }
  }
}
