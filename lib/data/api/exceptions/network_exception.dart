class NetworkException implements Exception {
  final String requestName;
  final int? code;
  final String errorMessage;

  const NetworkException({
    required this.requestName,
    required this.code,
    required this.errorMessage,
  });

  @override
  String toString() {
    return "В запросе'$requestName' возникла ошибка: ${code ?? ''} $errorMessage";
  }
}
