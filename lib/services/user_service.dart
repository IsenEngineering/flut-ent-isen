
//Classe qui va gérer le username
class UserManager {
  static final UserManager _instance = UserManager._internal();
  late String _username;
  UserManager._internal();


  static UserManager getInstance() {
    return _instance;
  }

  void setUsername(String token) { //setter
    _username = token;
  }


  String getUsername() { //getter
    return _username;
  }
}

