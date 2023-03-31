class UserModel {
  String _name;
  String _password;
  final String _email;
  String? _department;
  String? _profile;

  UserModel(this._name, this._email, this._password);

  String get getName => _name;

  set setName(String name) {
    if (name.isNotEmpty && name != '' && name != ' ') {
      _name = name;
    }
  }

  String? get getDepartment => _department;
  set setDepartment(String department) => _department = department;

  String? get getProfile => _profile;
  set setProfile(String profile) => _profile = profile;

  String get getEmail => _email;

  set setPassword(String password) {
    if (password.isNotEmpty && password != '' && password != ' ') {
      _password = password;
    }
  }

  Map<String, dynamic> get toMap {
    return {
      'name': _name,
      'email': _email,
      'senha': _password,
      'department': _department,
      'profile': _profile,
    };
  }
}
