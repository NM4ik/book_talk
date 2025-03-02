/// Represents a response from a REST API.
class RestResponse {
  const RestResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errorDescription,
    required this.statusCode,
  });

  /// Whether the request was successful or not.
  final bool success;

  /// The message associated with the response.
  final String? message;

  /// The data associated with the response.
  final Map<String, Object?>? data;

  /// The error description associated with the response.
  final Map<String, Object?>? errorDescription;

  /// The status code associated with the response.
  final int? statusCode;
}
