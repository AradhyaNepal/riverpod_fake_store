
class Auth {
  String userName;
  String token;
  String phone;

  Auth({
    required this.userName,
    required this.token,
    required this.phone,
  });

  factory Auth.notRegistered() => Auth(userName: "", token: "", phone: "");

  bool get notRegistered => userName.isEmpty || token.isEmpty || phone.isEmpty;
}
