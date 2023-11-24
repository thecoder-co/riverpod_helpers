class StringException implements Exception {
  final String message;

  StringException(this.message);

  @override
  String toString() => message;
}
