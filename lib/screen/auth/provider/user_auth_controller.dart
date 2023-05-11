import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/enum/status.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/fake_server/fake_login.dart';

import '../model/auth.dart';

final isRegistered = StateProvider<bool>((ref) {
  final value = ref.watch(userAuthController) as GenericState<Auth>;
  return !value.data.notRegistered;
});
final userAuthController = StateNotifierProvider(
  (ref) => AuthStateNotifier(
    GenericState.loading(Auth.notRegistered()),
  ),
);

class AuthStateNotifier extends StateNotifier<GenericState<Auth>> {
  AuthStateNotifier(
    super.state,
  );

  void login(String userName, String password) {
    final response =
        FakeLoginServer().performLoginAndReturnToken(userName, password);
    if (response == null) {
      state = state.copyWith(
        status: Status.error,
        errorMessage: "Invalid Credentials",
      );
    } else {
      state = state.copyWith(
        status: Status.success,
        data: Auth(
          userName: userName,
          token: response.token,
          phone: response.phone,
        ),
      );
    }
  }

  void logout() {
    state = state.copyWith(
      status: Status.loading,
      errorMessage: "",
      data: Auth.notRegistered(),
    );
  }
}
