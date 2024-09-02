class UserInfo {
  String username;
  String password;

  UserInfo({required String username, required String password})
      : username = username,
        password = password;

  String getUsername() {
    return username;
  }

  String getPassword() {
    return password;
  }
}
