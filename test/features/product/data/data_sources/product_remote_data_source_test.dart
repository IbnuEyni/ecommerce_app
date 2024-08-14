import 'dart:convert';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('createProduct', () {
    final tid = 1;
    final tname = 'name';
    final tdescription = 'descritptioin';
    final timageUrl = 'imageUrl';
    final tprice = 1;

    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    void setUpCreateMockHttpClientSuccess201() {
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 201));
    }

    void setCreateUpMockHttpClientFailure404() {
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      )).thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test('''should perform a POST request on URL with product being the
     end point and with application/json with header''', () async {
      //arrange
      setUpCreateMockHttpClientSuccess201();
      //act
      await dataSource.createProduct(
          tid, tname, tdescription, timageUrl, tprice);
      //assert
      verify(mockHttpClient.post(
        Uri.parse(Urls.baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      ));
    });

    test('should return Product when the response code iss 200 (success)',
        () async {
      //arrange
      setUpCreateMockHttpClientSuccess201();
      //act
      final result = await dataSource.createProduct(
          tid, tname, tdescription, timageUrl, tprice);
      // assert
      expect(result, equals(tProductModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Arrange
      setCreateUpMockHttpClientFailure404();

      // Act
      final call = dataSource.createProduct;

      // Assert
      expect(() => call(tid, tname, tdescription, timageUrl, tprice),
          throwsA(isA<ServerException>()));
    });
  });
  group('detailProduct', () {
    final tid = 1;
    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    void setUpDetailMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
    }

    void setUpDetailMockHttpClientFailure404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test('''should perform a GET request on URL with product being the
     end point and with application/json with header''', () async {
      //arrange
      setUpDetailMockHttpClientSuccess200();
      //act
      await dataSource.detailProduct(tid);
      //assert
      verify(mockHttpClient.get(Uri.parse('${Urls.baseUrl}/$tid'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Product when the response code iss 200 (success)',
        () async {
      //arrange
      setUpDetailMockHttpClientSuccess200();
      //act
      final result = await dataSource.detailProduct(tid);
      // assert
      expect(result, equals(tProductModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Arrange
      setUpDetailMockHttpClientFailure404();

      // Act
      final call = dataSource.detailProduct;

      // Assert
      expect(() => call(tid), throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    final tid = 1;
    final tname = 'name';
    final tdescription = 'descritptioin';
    final timageUrl = 'imageUrl';
    final tprice = 1;

    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    void setUpUpdateMockHttpClientSuccess200() {
      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 200));
    }

    void setUpUpdateMockHttpClientFailure404() {
      when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      )).thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test('''should perform a POST request on URL with product being the
     end point and with application/json with header''', () async {
      //arrange
      setUpUpdateMockHttpClientSuccess200();
      //act
      await dataSource.updateProduct(
          tid, tname, tdescription, timageUrl, tprice);
      //assert
      verify(mockHttpClient.put(
        Uri.parse('${Urls.baseUrl}/$tid'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': tid,
          'name': tname,
          'description': tdescription,
          'imageUrl': timageUrl,
          'price': tprice,
        }),
      ));
    });

    test('should return Product when the response code iss 200 (success)',
        () async {
      //arrange
      setUpUpdateMockHttpClientSuccess200();
      //act
      final result = await dataSource.updateProduct(
          tid, tname, tdescription, timageUrl, tprice);
      // assert
      expect(result, equals(tProductModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Arrange
      setUpUpdateMockHttpClientFailure404();

      // Act
      final call = dataSource.updateProduct;

      // Assert
      expect(() => call(tid, tname, tdescription, timageUrl, tprice),
          throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    final tid = 1;
    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    void setUpDeleteMockHttpClientSuccess200() {
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
    }

    void setDeleteUpMockHttpClientFailure404() {
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test('''should perform a GET request on URL with product being the
     end point and with application/json with header''', () async {
      //arrange
      setUpDeleteMockHttpClientSuccess200();
      //act
      await dataSource.deleteProduct(tid);
      //assert
      verify(mockHttpClient.delete(Uri.parse('${Urls.baseUrl}/$tid'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Product when the response code iss 200 (success)',
        () async {
      //arrange
      setUpDeleteMockHttpClientSuccess200();
      //act
      final result = await dataSource.deleteProduct(tid);
      // assert
      expect(result, equals(tProductModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // Arrange
      setDeleteUpMockHttpClientFailure404();

      // Act
      final call = dataSource.deleteProduct;

      // Assert
      expect(() => call(tid), throwsA(isA<ServerException>()));
    });
  });
}
