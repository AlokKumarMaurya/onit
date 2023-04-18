class DataLayerException implements Exception {
  final String _message;
  final String _prefix;

  DataLayerException([this._message = '', this._prefix = '']);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

class RequestException extends DataLayerException {
  RequestException([String? message]) : super(message ?? "", "Request Error: ");
}

class AuthException extends DataLayerException {
  AuthException([String? message]) : super(message ?? "", 'Auth Error');
}

class ServerException extends DataLayerException {
  ServerException([String? message]) : super(message ?? "", 'Server Error');
}

class ValidationException extends DataLayerException {
  ValidationException([String? message]) : super(message ?? "", 'Validation Error');
}

class ConnectivityException extends DataLayerException {
  ConnectivityException() : super("Check your internet connection", 'Connectivity Error');
}
