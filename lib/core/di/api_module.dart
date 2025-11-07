import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../feature/data/datasource/books_api_client.dart';

@module
abstract class ApiModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio();

    // dio.options.headers = {
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json',
    // };
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.interceptors.add(LogInterceptor());
    return dio;
  }

  @lazySingleton
  BooksApiClient booksApiClient(Dio dio) => BooksApiClient(dio);
}
