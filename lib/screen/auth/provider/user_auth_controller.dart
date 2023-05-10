import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/auth/fake_server/fake_login.dart';

import '../model/auth.dart';

final isRegistered = StateProvider<bool>((ref) {
  final value = ref.watch(userAuthController) as Auth;
  return !value.notRegistered;
});
final userAuthController = StateNotifierProvider(
  (ref) => AuthStateNotifier(
    Auth.notRegistered(),
  ),
);

class AuthStateNotifier extends StateNotifier<Auth> {
  AuthStateNotifier(
    super.state,
  );

  ///Throws error if cannot login, with message of why can't do the login
  void login(String userName, String password) {
    final response =
        FakeLoginServer().performLoginAndReturnToken(userName, password);
    if (response == null) throw "Wrong Credentials";
    state = Auth(
      userName: userName,
      token: response.token,
      phone: response.phone,
    );
  }

  void logout(){
    state=Auth.notRegistered();
  }
}
