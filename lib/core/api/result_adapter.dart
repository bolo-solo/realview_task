import 'package:multiple_result/multiple_result.dart';
import 'package:retrofit/retrofit.dart';

import 'api_helpers.dart';

class ResultAdapter<T> extends CallAdapter<Future<T>, AsyncResult<T>> {
  @override
  AsyncResult<T> adapt(Future<T> Function() call) async {
    try {
      final response = await call();
      return Success(response);
    } catch (e) {
      return Error(e is Exception ? e : Exception('Unknown error occurred'));
    }
  }
}
