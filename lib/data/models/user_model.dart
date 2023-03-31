class UserModel {
  String _name;
  String _password;
  final String _email;

  UserModel(this._name, this._email, this._password);

  String get getName {
    return _name;
  }

  String get getEmail {
    return _email;
  }

  set setName(String name) {
    if (name.isNotEmpty && name != '' && name != ' ') {
      _name = name;
    }
  }

  set setPassword(String password) {
    if (password.isNotEmpty && password != '' && password != ' ') {
      _password = password;
    }
  }

  Map<String, dynamic> get toMap {
    return {'name': _name, 'email': _email, 'senha': _password};
  }
}
