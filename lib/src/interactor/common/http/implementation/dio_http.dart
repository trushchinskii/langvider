import 'package:dio/dio.dart';
import 'package:langvider/src/interactor/common/http/http.dart';

/// Custom http client by dio
class DioHttp implements Http {
  Dio _dio = Dio();

  DioHttp() {
    _dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<Response> post({
    String url,
    HttpRequest request,
  }) {
    return _dio.post(
      url,
      queryParameters: request.json,
    );
  }
}
