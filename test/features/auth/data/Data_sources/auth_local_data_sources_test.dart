import 'dart:convert';

import 'package:ecommerce_app/features/auth/data/data_sources/local_data_sources.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../product/data/data_sources/product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        AuthLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cacheAuthToken', () {
    final tAuthToken = 'abc123';
    // AuthUserModel.fromJson(json.decode(fixture('auth_token'))['data'])
    //     .token;

    test('should call SharedPreferences to cache the token', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheAuthToken(tAuthToken);

      // Assert
      verify(mockSharedPreferences.setString(
        CACHED_AUTH_TOKEN,
        tAuthToken,
      ));
    });
  });

  group('getAuthToken', () {
    final tAuthToken = 'abc123';

    test('should return cached token from SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(tAuthToken);

      // Act
      final result = await dataSource.getAuthToken();

      // Assert
      verify(mockSharedPreferences.getString(CACHED_AUTH_TOKEN));
      expect(result, tAuthToken);
    });

    test('should return null when no token is cached', () async {
      // Arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // Act
      final result = await dataSource.getAuthToken();

      // Assert
      verify(mockSharedPreferences.getString(CACHED_AUTH_TOKEN));
      expect(result, null);
    });
  });

  group('clearAuthToken', () {
    test('should call SharedPreferences to remove the token', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // Act
      await dataSource.clearAuthToken();

      // Assert
      verify(mockSharedPreferences.remove(CACHED_AUTH_TOKEN));
    });
  });
}
