/// Custom http client
abstract class Http {
  /// Post request
  Future post<T>({
    String url,
    HttpRequest request,
  });
}

/// Base class for all http requests
abstract class HttpRequest {
  Map<String, Object> get json;
}
