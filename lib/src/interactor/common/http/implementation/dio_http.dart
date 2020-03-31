import 'package:dio/dio.dart';
import 'package:langvider/src/interactor/common/http/http.dart';

/// Custom http client by dio
class DioHttp implements Http {
  DioHttp() {
    _dio.interceptors.add(LogInterceptor());
  }

  final _dio = Dio();

  @override
  Future<Response<T>> post<T>({
    String url,
    HttpRequest request,
  }) {
    return _dio.post<T>(
      url,
      queryParameters: request.json,
    );
  }
}
