class UserModel {
  String _name;
  String _password;
  final String _email;
  String? department;
  String? profile;

  UserModel(this._name, this._email, this._password,
      {this.department, this.profile});

  String get email => _email;

  String get name => _name;

  set name(String name) {
    if (name.isNotEmpty && name != '' && name != ' ') {
      _name = name;
    }
  }

  String get password => _password;

  set password(String password) {
    if (password.isNotEmpty && password != '' && password != ' ') {
      _password = password;
    }
  }

  Map<String, dynamic> get toMap {
    return {
      'name': _name,
      'email': _email,
      'password': _password,
      'department': department,
      'profile': profile,
    };
  }

  static UserModel toUser(Map<String, dynamic> userData) {
    String name = userData['name'];
    String email = userData['email'];
    String password = userData['password'];
    String? department = userData['department'];
    String? profile = userData['profile'];
    return UserModel(name, email, password,
        department: department, profile: profile);
  }

  @override
  String toString() {
    return toMap.toString();
  }
}
