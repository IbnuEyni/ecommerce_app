import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('detailProduct', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    final tid = '1';

    final tProductModel = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0,
    );

    final Product tProduct = tProductModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.detailProduct(tid))
          .thenAnswer((_) async => tProductModel);
      when(mockLocalDataSource.getLastProduct())
          .thenAnswer((_) async => tProductModel);
      //act
      await repository.detailProduct(tid);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.detailProduct(tid))
              .thenAnswer((_) async => tProductModel);

          //act
          final result = await repository.detailProduct(tid);

          //assert
          verify(
            mockRemoteDataSource.detailProduct(tid),
          );
          expect(result, equals(Right(tProductModel)));
        },
      );
      test(
        'should cache data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.detailProduct(tid))
              .thenAnswer((_) async => tProductModel);

          //act
          await repository.detailProduct(tid);

          //assert
          verify(
            mockRemoteDataSource.detailProduct(tid),
          );
          verify(mockLocalDataSource.cacheProduct(tProductModel));
        },
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.detailProduct(tid))
            .thenThrow(ServerException());
        //act
        final result = await repository.detailProduct(tid);

        //assert
        verify(mockRemoteDataSource.detailProduct(tid));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test(
        'should return CahsFailure when there is no locally cached data is not present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastProduct())
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.detailProduct(tid);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastProduct());
          expect(result, equals(Right(tProductModel)));
        },
      );

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastProduct())
              .thenThrow(CacheException());
          // act
          final result = await repository.detailProduct(tid);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastProduct());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
  group('createProduct', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    final tid = '1';
    final tname = 'name';
    final tdescription = 'description';
    final timageUrl = 'imageUrl';
    final tprice = 10.0;

    final tProductModel = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0,
    );

    final Product tProduct = tProductModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createProduct(
              tid, tname, tdescription, timageUrl, tprice))
          .thenAnswer((_) async => tProductModel);
      when(mockLocalDataSource.getLastProduct())
          .thenAnswer((_) async => tProductModel);
      // //act
      await repository.createProduct(
          tid, tname, tdescription, timageUrl, tprice);
      // //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.createProduct(
                  tid, tname, tdescription, timageUrl, tprice))
              .thenAnswer((_) async => tProductModel);

          //act
          final result = await repository.createProduct(
              tid, tname, tdescription, timageUrl, tprice);

          //assert
          verify(
            mockRemoteDataSource.createProduct(
                tid, tname, tdescription, timageUrl, tprice),
          );
          expect(result, equals(Right(tProductModel)));
        },
      );
      test(
        'should cache data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.createProduct(
                  tid, tname, tdescription, timageUrl, tprice))
              .thenAnswer((_) async => tProductModel);

          //act
          await repository.createProduct(
              tid, tname, tdescription, timageUrl, tprice);

          //assert
          verify(
            mockRemoteDataSource.createProduct(
                tid, tname, tdescription, timageUrl, tprice),
          );
          verify(mockLocalDataSource.cacheProduct(tProductModel));
        },
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.createProduct(
                tid, tname, tdescription, timageUrl, tprice))
            .thenThrow(ServerException());
        //act
        final result = await repository.createProduct(
            tid, tname, tdescription, timageUrl, tprice);

        //assert
        verify(mockRemoteDataSource.createProduct(
            tid, tname, tdescription, timageUrl, tprice));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });
  });
  group('updateProduct', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    final tid = '1';
    final tname = 'name';
    final tdescription = 'description';
    final timageUrl = 'imageUrl';
    final tprice = 10.0;

    final tProductModel = ProductModel(
      id: '1',
      name: 'name',
      description: 'description',
      imageUrl: 'imageUrl',
      price: 1.0,
    );

    final Product tProduct = tProductModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.detailProduct(tid))
          .thenAnswer((_) async => tProductModel);
      when(mockLocalDataSource.getLastProduct())
          .thenAnswer((_) async => tProductModel);
      //act
      await repository.detailProduct(tid);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateProduct(
                  tid, tname, tdescription, timageUrl, tprice))
              .thenAnswer((_) async => tProductModel);

          //act
          final result = await repository.updateProduct(
              tid, tname, tdescription, timageUrl, tprice);

          //assert
          verify(
            mockRemoteDataSource.updateProduct(
                tid, tname, tdescription, timageUrl, tprice),
          );
          expect(result, equals(Right(tProductModel)));
        },
      );
      test(
        'should cache data when the call for remote data is succesful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateProduct(
                  tid, tname, tdescription, timageUrl, tprice))
              .thenAnswer((_) async => tProductModel);

          //act
          await repository.updateProduct(
              tid, tname, tdescription, timageUrl, tprice);

          //assert
          verify(
            mockRemoteDataSource.updateProduct(
                tid, tname, tdescription, timageUrl, tprice),
          );
          verify(mockLocalDataSource.cacheProduct(tProductModel));
        },
      );

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.updateProduct(
                tid, tname, tdescription, timageUrl, tprice))
            .thenThrow(ServerException());
        //act
        final result = await repository.updateProduct(
            tid, tname, tdescription, timageUrl, tprice);

        //assert
        verify(mockRemoteDataSource.updateProduct(
            tid, tname, tdescription, timageUrl, tprice));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('deleteProduct', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    final tid = '1';
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct(tid))
          .thenAnswer((_) async => unit);
      when(mockRemoteDataSource.deleteProduct(tid))
          .thenThrow(ServerException());

      // Act
      await repository.deleteProduct(tid);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
        'should return Right(unit) when the call to remote data source is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.deleteProduct(tid))
              .thenAnswer((_) async => unit);

          // Act
          final result = await repository.deleteProduct(tid);

          // Assert
          verify(mockRemoteDataSource.deleteProduct(tid));
          expect(result, equals(const Right(unit)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(mockRemoteDataSource.deleteProduct(tid))
              .thenThrow(ServerException());

          // Act
          final result = await repository.deleteProduct(tid);

          // Assert
          verify(mockRemoteDataSource.deleteProduct(tid));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    runTestsOffline(() {
      test(
        'should return NetworkFailure when there is no internet connection',
        () async {
          // Arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

          // Act
          final result = await repository.deleteProduct(tid);

          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(NetworkFailure())));
        },
      );
    });
  });

  group('listProducts', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    final tProductModels = <ProductModel>[
      ProductModel(
        id: '1',
        name: 'name1',
        description: 'description1',
        imageUrl: 'imageUrl1',
        price: 10.0,
      ),
      ProductModel(
        id: '2',
        name: 'name2',
        description: 'description2',
        imageUrl: 'imageUrl2',
        price: 20.0,
      ),
    ];
    final tProducts = tProductModels
        .map((model) => convertProductModelToProduct(model))
        .toList();

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.listProducts())
          .thenAnswer((_) async => tProductModels);
      when(mockLocalDataSource.getCachedProducts())
          .thenAnswer((_) async => tProductModels);
      //act
      await repository.listProducts();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.listProducts())
              .thenAnswer((_) async => tProductModels);

          // Act
          final result = await repository.listProducts();

          // Assert
          verify(mockRemoteDataSource.listProducts());
          expect(result, equals(Right(tProductModels)));
        },
      );

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.listProducts()).thenThrow(ServerException());
        //act
        final result = await repository.listProducts();
        //assert
        verify(mockRemoteDataSource.listProducts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() async {
      test(
          'should return cached products when there is no internet connection and cached data is available',
          () async {
        //arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => tProductModels);
        //act
        final result = await repository.listProducts();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedProducts());
        expect(result, equals(Right(tProductModels)));
      });

      test(
          'should return CacheFailure when there is no internet connection and no cached data is available',
          () async {
        //arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenThrow(CacheException());
        //act
        final result = await repository.listProducts();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedProducts());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
