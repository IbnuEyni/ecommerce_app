import 'package:ecommerce_app/features/auth/domain/entity/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required String id,
    required String email,
    required String name,
    required String token,
  }) : super(
          id: id,
          email: email,
          name: name,
          token: token,
        );

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
    };
  }
}
