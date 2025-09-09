final class Result<T, E extends Exception> {
  final T? data;
  final E? error;

  Result.ok(this.data) : error = null;
  Result.error(this.error) : data = null;

  bool get isOk => error == null;
  bool get isError => error != null;

  void when({Function(T)? onOk, Function(E)? onError}) {
    if (isOk) {
      onOk?.call(data as T);
    } else {
      onError?.call(error as E);
    }
  }
}
