class ConfigDbException implements Exception {
  final String msg;
  ConfigDbException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
