class DataResult<T> {
  final bool success;
  final String message;
  final T ? data;

  DataResult({
    required this.success,
    required this.message,
    required this.data,
  });
}
