abstract class Streamable<T> {
  Stream<T> get stream;

  void close();
}
