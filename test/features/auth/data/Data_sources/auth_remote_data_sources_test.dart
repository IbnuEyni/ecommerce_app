import 'dart:convert';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/auth/data/data_sources/remote_data_resources.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../product/data/data_sources/product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('signUp', () {
    final tName = 'John Doe';
    final tEmail = 'test@test.com';
    final tPassword = 'password123';
    final tAuthUserModel = AuthUserModel(
      id: '123',
      name: tName,
      email: tEmail,
    );

    test('should return AuthUserModel when the response code is 201 (Created)',
        () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            jsonEncode({
              'id': '123',
              'name': tName,
              'email': tEmail,
            }),
            201,
          ));

      // Act
      final result = await dataSource.signUp(
          name: tName, email: tEmail, password: tPassword);

      // Assert
      expect(result, equals(tAuthUserModel));
    });

    test('should throw a ServerException when the response code is not 201',
        () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Something went wrong', 400));

      // Act
      final call = dataSource.signUp;

      // Assert
      expect(() => call(name: tName, email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()));
    });
  });

  group('login', () {
    final tEmail = 'test@test.com';
    final tPassword = 'password123';
    final tToken = 'abc123';

    test('should return a token when the response code is 200 (OK)', () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer(
          (_) async => http.Response(json.encode({'token': tToken}), 200));

      // Act
      final result = await dataSource.login(email: tEmail, password: tPassword);

      // Assert
      expect(result, equals(tToken));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()));
    });
  });

  group('me', () {
    final tToken = 'abc123';
    final tAuthUserModel = AuthUserModel(
      id: '123',
      name: 'John Doe',
      email: 'test@test.com',
    );

    test('should return AuthUserModel when the response code is 200 (OK)',
        () async {
      // Arrange
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
            json.encode({
              'id': '123',
              'name': 'John Doe',
              'email': 'test@test.com',
            }),
            200,
          ));

      // Act
      final result = await dataSource.me(token: tToken);

      // Assert
      expect(result, equals(tAuthUserModel));
      verify(mockHttpClient.get(
        Uri.parse(
            'https://g5-flutter-learning-path-be.onrender.com/api/v2/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tToken',
        },
      ));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act
      final call = dataSource.me;

      // Assert
      expect(() => call(token: tToken), throwsA(isA<ServerException>()));
    });
  });
}
