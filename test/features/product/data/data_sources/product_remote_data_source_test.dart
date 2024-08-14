// import 'dart:io';

import 'package:ecommerce_app/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });
}
