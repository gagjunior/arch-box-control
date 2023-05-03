class NameUserException implements Exception {
  final String _msg;

  NameUserException(this._msg);

  @override
  String toString() {
    return _msg;
  }
}

class EmailUserException implements Exception {
  final String _msg;

  EmailUserException(this._msg);

  @override
  String toString() => _msg;
}

class PasswordUserException implements Exception {
  final String _msg;

  PasswordUserException(this._msg);

  @override
  String toString() => _msg;
}

class NotFoundUserException implements Exception {
  final String _msg;

  NotFoundUserException(this._msg);

  @override
  String toString() => _msg;
}
