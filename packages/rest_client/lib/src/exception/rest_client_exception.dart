/// Exceptions thrown by the REST client.
sealed class RestClientException implements Exception {
  const RestClientException({
    required this.message,
    required this.cause,
  });

  final String message;
  final Object cause;
}

/// Exceptions thrown by the REST client.
final class ClientException extends RestClientException {
  const ClientException({required super.message, required super.cause});

  @override
  String toString() => 'ClientException(message: $message, cause: $cause)';
}
