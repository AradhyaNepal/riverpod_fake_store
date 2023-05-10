import 'dart:math';

class FakeLoginServer {
  ///If empty it means wrong username or password
  FakeLoginResponse? performLoginAndReturnToken(String username, String password) {
    if(Random().nextInt(5)==1)return null;
    return FakeLoginResponse(phone: "9800915400", token: "BelloIAmToken");
  }
}

class FakeLoginResponse {
  String phone;
  String token;

  FakeLoginResponse({
    required this.phone,
    required this.token,
  });
}
