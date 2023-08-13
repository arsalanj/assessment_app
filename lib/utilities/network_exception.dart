/// An exception class representing network-related errors.
///
/// This exception is thrown when there is an issue related to network connectivity,
/// such as inability to establish a connection or timeouts.
class NetworkException implements Exception {
  /// The error message describing the network-related issue.
  final String message;

  /// Constructs a [NetworkException] with the given [message].
  NetworkException(this.message);

  @override
  String toString() => message;
}

/// An exception class representing API-related errors.
///
/// This exception is thrown when there is an issue with the API itself,
/// such as receiving unexpected or erroneous data from the API endpoints.
class ApiException implements Exception {
  /// The error message describing the API-related issue.
  final String message;

  /// Constructs an [ApiException] with the given [message].
  ApiException(this.message);

  @override
  String toString() => message;
}
